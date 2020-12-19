# -*- coding: utf-8 -*-
#/usr/bin/python2.7

from random import choice

def read_file():
    words = []
    with open("heiseticker-text.txt", 'r') as f:
        for line in f.readlines():
            words.append(line[:-1]) ##hau die '\n' chars raus
    return words

##
# Wahrscheinlichkeiten ergeben sich hier implizit, da zu jedem Wort eine Liste 
# mit Folgewörtern existiert --> mehrfach vorhandene Wörter = große Wahrscheinlichkeit
##
def build_bigram(words):
    base = {}
    for i in range(0, len(words)):
        if i+1 < len(words):
            if not base.has_key(words[i]):
                base[words[i]] = [words[i+1]]
            else:
                base[words[i]].append(words[i+1])
           
    return base

def build_trigram(words):
    base = {}
    for i in range(0, len(words) - 2):
        if not base.has_key(words[i]):
            base[words[i]] = [[words[i+1], words[i+2]]]
        else:
            base[words[i]].append([words[i+1], words[i+2]])
    return base

def build_quadrogram(words):
    base = {}
    for i in range(0, len(words) - 3):
        if not base.has_key(words[i]):
            base[words[i]] = [[words[i+1], words[i+2], words[i+3]]]
        else:
            base[words[i]].append([words[i+1], words[i+2], words[i+3]])
    return base

def make_random_sentence(start_word, word_count, net_type = 'bigram'):
    dic = {}
    if net_type == 'bigram':
        dic = build_bigram(read_file())
        generate_bi_sentence(start_word, word_count, dic)
    elif net_type == 'trigram':
        dic = build_trigram(read_file())
        generate_tri_sentence(start_word, word_count, dic)
    elif net_type == 'quadrogram':
        dic = build_quadrogram(read_file())
        generate_quad_sentence(start_word, word_count, dic)

def generate_bi_sentence(start_word, word_count, dic):
    i = 0
    sentence = ""
    current = ""
    if dic.keys().count(start_word) != 0:
        current = start_word            
    else:
        print("The word '" + start_word + "' could not be found in the training set")
        return
        
    sentence = sentence + current
    i = i+1
    while i <= word_count:
        if len(dic[current]) > 1:
            current = choice(dic[current])
        else:
            current = dic[current][0]
        if current == "," or current == ".":
            sentence = sentence + current
        else:
            sentence = sentence + " " + current
        i = i + 1
    print(sentence)

def generate_tri_sentence(start_word, word_count, dic):
    # {"key" : [[w1, w2], [w1, w2],...,[w1,w2]]}
    i = 0
    sentence = ""
    current = ""
    if dic.keys().count(start_word) != 0:
        current = start_word            
    else:
        print("The word '" + start_word + "' could not be found in the training set")
        return
        
    sentence = sentence + current
    i = i+1
    while i <= word_count:
        if len(dic[current]) > 1:
            current = choice(dic[current])[1]
        else:
            current = dic[current][0][1]
        if current == "," or current == ".":
            sentence = sentence + current
        else:
            sentence = sentence + " " + current
        i = i + 1
    print(sentence)

def generate_quad_sentence(start_word, word_count, dic):
    # {"key" : [[w1, w2, w3], [w1, w2, w3],...,[w1, w2, w3]]}
    i = 0
    sentence = ""
    current = ""
    if dic.keys().count(start_word) != 0:
        current = start_word            
    else:
        print("The word '" + start_word + "' could not be found in the training set")
        return
        
    sentence = sentence + current
    i = i+1
    while i <= word_count:
        if len(dic[current]) > 1:
            current = choice(dic[current])[2]
        else:
            current = dic[current][0][2]
        if current == "," or current == ".":
            sentence = sentence + current
        else:
            sentence = sentence + " " + current
        i = i + 1
    print(sentence)


if __name__ == "__main__":
    word = "auf"
    count = 20
    net_type = "quadrogram"
    make_random_sentence(word, count, net_type)
        
