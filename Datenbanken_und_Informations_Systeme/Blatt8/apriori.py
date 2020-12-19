#!/bin/env python3
"""Implementation of a simple apriori algorithm for transactions."""
from pprint import pprint
from typing import List, Set

from data import extract_transactions, Candidate, Transaction


def calc_support(transactions: List[Transaction], candidates: List[Candidate]):
    """Calculate the support for each candidate. I.e. how many transactions contain this candidate."""
    # Iterate over every transaction and check for each candidate whether it's contained in the transaction
    print('Calculating support')
    counter = 0
    for transaction in transactions:
        # Reset transaction counter
        transaction.usages = 0

        counter += 1
        if counter % 5000 == 0:
            print(f'Finished transaction {counter} of {len(transactions)}')
        for candidate in candidates:
            if candidate.items.issubset(transaction.items):
                candidate.support += 1
                transaction.usages += 1


def ignore_duplicate(candidate: Candidate, added_items):
    """Check whether we should ignore this candidate, since this constellation already has been generated earlier."""
    for added_item in added_items:
        if added_item in candidate.items:
            return True

    return False


def generate_candidates(candidates: List[Candidate], items: List[int]):
    """Create all new possible constellations of items."""
    new_candidates: List[Candidate] = []
    added_items = []
    for item in items:
        for candidate in candidates:
            # Item already in candidate item list. Ignore
            if item in candidate.items:
                continue

            # Handle duplicates
            if ignore_duplicate(candidate, added_items):
                continue

            # Create new candidate with items from previous round and new item
            # Be careful to call set(old_set) to clone it. Otherwise we pass a reference
            new_candidate = Candidate(set(candidate.items))
            new_candidate.items.add(item)

            new_candidates.append(new_candidate)

        added_items.append(item)

    return new_candidates


def remove_invalid_candidates(candidates: List[Candidate], min_support: int):
    """Remove all candidates, which don't are above the min support threshold."""
    def above_threshold(candidate: Candidate):
        return candidate.support >= min_support

    return list(filter(above_threshold, candidates))


def remove_unused_transactions(transactions: List[Transaction]):
    """Remove all transactions, which aren't used by any candidate."""
    def above_threshold(transaction: Transaction):
        if len(transaction.items) <= 1:
            return False
        return transaction.usages != 0

    return list(filter(above_threshold, transactions))


def main():
    """Program entry point."""
    transactions = extract_transactions()
    total_transactions = len(transactions)
    min_support = total_transactions / 100

    # Create a set of all possible item numbers
    all_items: Set[int] = set()
    for transaction in transactions:
        all_items = all_items.union(transaction.items)

    # Variables for storing all viable candidates and their respective round
    results_per_round: List[List[Candidate]] = [[Candidate(set())]]
    current_round = 0

    # Keep generating new candidates until we no longer find candidates above the min support
    while len(results_per_round[current_round]) != 0:
        # Generate the new candidates
        old_candidates: List[Candidate] = results_per_round[current_round]
        next_candidates = generate_candidates(old_candidates, all_items)

        print(f'\nFound {len(next_candidates)} new candidates')

        # Calculate the support and remove invalid candidates and unused transactions
        calc_support(transactions, next_candidates)
        next_candidates = remove_invalid_candidates(next_candidates, min_support)
        transactions = remove_unused_transactions(transactions)

        if current_round == 0:
            # Little hack:
            # Calculate subset of all singular transaction items that are above min_support.
            # This saves us a few cycles, since we instantly ignore all items which would fail anyway.
            all_items = [next(iter(candidate.items)) for candidate in next_candidates]

        print(f'{len(next_candidates)} candidates left')
        print(f'{len(transactions)} transactions left')

        results_per_round.append(next_candidates)
        current_round += 1

        print(f"\nCandidates of round {current_round}:")
        pprint(next_candidates)

    print(f"All candidates sorted by round:")
    pprint(results_per_round)


if __name__ == '__main__':
    main()
