#!/usr/bin/env python3
# Produces an arc consistent network

import string
from itertools import product

words = ["add", "ado", "age", "ago", "aid", "ail", "aim", "air",
"and", "any", "ape", "apt", "arc", "are", "ark", "arm",
"art", "ash", "ask", "auk", "awe", "awl", "aye", "bad",
"bag", "ban", "bat", "bee", "boa", "ear", "eel", "eft",
"far", "fat", "fit", "lee", "oaf", "rat", "tar", "tie"]

lowercaseLetters =  ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']

# Variables, Domain and Constraint initialization
variables = set()
domains = {}
constraints = []

# Function for checking, if a word is valid. This is our constraint
def word_check(char0, char1, char2):
    return (char0 + char1 + char2) in words

# Initialize grid/variables and constraints
for x in range(3):
    # Initialize constraint rows
    constraints.append({"nodes" :[(0, x), (1, x), (2, x)], "func": word_check})
    constraints.append({"nodes" :[(x, 0), (x, 1), (x, 2)], "func": word_check})
    # Initialize variables/grid
    for y in range(3):
        variables.add((x,y))
        domains[(x,y)] = lowercaseLetters


# Checks if there is a valid combination for the constraint
def checkCombinations(combinations, constraint):
    for combination in combinations:
        if constraint['func'](*combination):
            return True
    return False

# Get all new arcs, which should be updated/checked
def getToBeUpdatedConstraints(node, constraint):
    toBeUpdated = []
    for cons in constraints:
        if constraint == cons:
            continue
        elif node not in constraint['nodes']:
            continue
        else:
            toBeUpdated += map(lambda newNode: {"node": newNode, "constraint": constraint}, cons["nodes"])
    return toBeUpdated

def gac():
    tda = []
    # Create initial TDA
    for constraint in constraints:
        partial_tda = map(lambda node: {"node": node, "constraint": constraint}, constraint["nodes"])
        tda = tda + list(partial_tda)

    # Iterate through tda
    while tda:
        currentArc = tda.pop()
        currentDomain = domains[currentArc['node']]
        currentConstraint = currentArc['constraint']

        # Check if the domain is valid for a given constraint
        newDomain = []
        for char in currentDomain:
            allChars = []
            for node in constraint["nodes"]:
                if node != currentArc['node']:
                    allChars.append(domains[node])
                else:
                    allChars.append([char])

            # Get all possible combinations using product() function.
            # This returns all possible Combinations as lists
            allCombinations = product(*allChars)
            if checkCombinations(allCombinations, currentConstraint):
                newDomain.append(char)

        # If the domain got modified, set the domain and add new arcs for constraint neigbours
        if newDomain is not currentDomain:
            domains[currentArc['node']] = newDomain
            toBeUpdated = getToBeUpdatedConstraints(node, currentConstraint)
            print(toBeUpdated)
            #tda += toBeUpdated
            print(len(tda))

gac()

for variable in variables:
    print(variable)
    print(domains[variable])
    print("")
