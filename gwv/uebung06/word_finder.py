#!/bin/env python3

words = set(["add", "ado", "age", "ago", "aid", "ail", "aim", "air",
"and", "any", "ape", "apt", "arc", "are", "ark", "arm",
"art", "ash", "ask", "auk", "awe", "awl", "aye", "bad",
"bag", "ban", "bat", "bee", "boa", "ear", "eel", "eft",
"far", "fat", "fit", "lee", "oaf", "rat", "tar", "tie"])

def build_domains():
    start = set()
    middle = set()
    end = set()
    for word in words:
        start.add(word[0])
        middle.add(word[1])
        end.add(word[2])
    return start, middle, end

def find_possible_v1(possible_start):
    possible = []
    for word in words:
        if not possible_start.isdisjoint([word[0]]) and not possible_start.isdisjoint([word[1]]) and not possible_start.isdisjoint([word[2]]):
            possible.append(word)
    print(len(possible))
    return possible

def find_possible_v2(possible_start, possible_middle, possible_end):
    possible = []
    p_s = possible_start.intersection(possible_middle)
    p_e = possible_middle.intersection(possible_end)
    for word in words:
        if not p_s.isdisjoint([word[0]]) and not p_e.isdisjoint([word[2]]):
            possible.append(word)
    print(len(possible))
    return possible

def find_possible_v3(possible_start, possible_middle, possible_end):
    possible = []
    p_s = possible_start.intersection(possible_end)
    p_m = possible_middle.intersection(possible_end)
    for word in words:
        if not p_s.isdisjoint([word[0]]) and not p_m.isdisjoint([word[1]]):
            possible.append(word)
    print(len(possible))
    return possible

def find_global_possible(poss_v1, poss_v2, poss_v3):
    global_possible = []
    for word in poss_v1:
        for word2 in poss_v2:
            for word3 in poss_v3:
                if not words.isdisjoint([str(word[0] + word2[0] + word3[0])]) and not words.isdisjoint([str(word[1] + word2[1] + word3[1])]) and not words.isdisjoint([str(word[2] + word2[2] + word3[2])]):
                    global_possible.append({'v1': word, 'v2': word2, 'v3': word3})
    return global_possible

def main():
    s,m,e = build_domains()
    return find_global_possible(find_possible_v1(s), find_possible_v2(s,m,e), find_possible_v3(s,m,e))

if __name__ == "__main__":
    print("Solutions to fill columns are:\n{0}\n".format(main()))
