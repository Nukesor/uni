#!/bin/env python3
"""Data related helper functions."""
from typing import Set


class Candidate:
    """Represents a possible constellation of items with it's support."""

    def __init__(self, items: Set[int]):
        """Create a new candidate."""
        self.items = items
        self.support = 0

    def __repr__(self):
        """Return string representation."""
        return f"Candidate: {self.items} - {self.support}"

    def __str__(self):
        """Return string representation."""
        return f"Candidate: {self.items} - {self.support}"


class Transaction:
    """Representation of a Transaction."""

    def __init__(self, items: Set[int]):
        """Create a new candidate."""
        self.items = items
        self.usages = 0

    def __repr__(self):
        """Return string representation."""
        return f"Transaction: {self.items} - {self.usages}"

    def __str__(self):
        """Return string representation."""
        return f"Transaction: {self.items} - {self.usages}"


def extract_transactions(file="./transactionslarge.txt"):
    """Extract all transactions from a given file."""
    transactions = []
    with open(file) as f:
        for line in f:
            transaction = line.strip().split(" ")
            items = set({int(i) for i in transaction})
            transactions.append(Transaction(items))
    return transactions
