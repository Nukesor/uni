#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from scipy.stats import rv_discrete


###
# Solution taken from here http://stackoverflow.com/questions/4265988/generate-random-numbers-with-a-given-numerical-distribution
# Documentation of superclass http://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.rv_discrete.html
#
# rv_discrete takes a set of variables with a certain probability value and is able to give back a "random" value using the rvs() method
# that is distributed as specified by the input probabilities.
###
class ProbabilityDist(rv_discrete):
    def __init__(self, vals, val_mapping):
        rv_discrete.__init__(self, name="ProbabilityDistribution", values=vals)
        self.prob_vals = vals[1]
        self.value_mapping = val_mapping  # Ex.: {0 : "ART", 1 : "NN", 2 : "NE"...}

    def pick_max_probability(self):
        return self.value_mapping[max(self.prob_vals)]

    def pick_value(self):
        #rvs() returns int based on probability distribution defined in 'vals' constructor argument
        return self.value_mapping[self.rvs()]
###
# Read a training data file and parse the content into a dictionary that maps
# tags to words, a transition distribution (tag_n+1|tag_n), and an
# emission distribution (word_n|tag_n)
#
# @return Dictionary<String, String>, Dictionary<String, ProbabilityDist>, Dictionary<String, ProbabilityDist>
###
def read_file():
    words2tag = {}
    with open("hdt-1-10000-train.tags", 'r') as test:
        lines = test.readlines()
        tag_counts = make_tag_counts(lines)
        for line in lines:
            if line != "\n":
                word, tag = line[:-1].split("\t")
                if word not in words2tag:
                    words2tag[word] = tag

    transition_distr= make_transition_distribution(tag_counts, lines)
    emission_distr = make_emission_distribution(tag_counts, lines)

    return words2tag, transition_distr, emission_distr


###
# Helper function to quickly have the total number of words tagged with
# a specific tag available
#
# @param List<String>
# @return Dictionary<String, int>
###
def make_tag_counts(lines):
    tags = {}
    for line in lines:
        if line != "\n":
            tag = line.split("\t")[1][:-1]
            if tag not in tags:
                tags[tag] = 1
            else:
                tags[tag] += 1
    return tags


###
# Parse training data to give out a dict that holds for every tag n
# a probability distribution for the next tag n+1
#
# @param Dictionary<String, int>, List<String>
# @return Dictionary<String, ProbabilityDist>
###
def make_transition_distribution(tag_count, lines):
    tag_probs = {}
    sentences = 0
    i = 0
    while i < len(lines):
        if lines[i] != "\n":
            if lines[i+1] != "\n":
                # Split the word/tag pair along the tab, select the tag and strip the trailing linebreak
                tag_n = lines[i].split("\t")[1][:-1]
                tag_n1 = lines[i+1].split("\t")[1][:-1]

                if tag_n not in tag_probs:
                    # We haven't seen this tag before, make new entry in dict
                    tag_probs[tag_n] = {tag_n1: {"prob": 1.0/tag_count[tag_n], "count": 1}}
                else:
                    if tag_n1 in tag_probs[tag_n]:
                        # We already have tag_n+1 as a child node of tag_n, increase its counter and recalculate the probability
                        tag_probs[tag_n][tag_n1]["count"] += 1
                        tag_probs[tag_n][tag_n1]["prob"] = float(tag_probs[tag_n][tag_n1]["count"]) / tag_count[tag_n]
                    else:
                        #we haven't seen this tag as a child of tag_n before, make a new entry in dict
                        tag_probs[tag_n][tag_n1] = {"prob": 1.0/tag_count[tag_n], "count": 1}
        i += 1

    return generate_probability_distribution(tag_probs)


###
# Parse training data to give out a dict that holds for every tag n
# a probability distribution for the observable output word n
#
# @param Dictionary<String, int>, List<String>
# @return Dictionary<String, ProbabilityDist>
###
def make_emission_distribution(tag_count, lines):
    emission_distr = {}

    for key in tag_count.keys(): #build dict with initial values
        emission_distr[key] = {"total_words": tag_count[key]}

    for line in lines:
        if line != "\n":
            word, tag = line[:-1].split("\t")
            if word not in emission_distr[tag]:
                emission_distr[tag][word] = {"count" : 1, "prob" : 1.0 / emission_distr[tag]["total_words"]}
            else:
                emission_distr[tag][word]["count"] += 1
                emission_distr[tag][word]["prob"] = float(emission_distr[tag][word]["count"]) / emission_distr[tag]["total_words"]

    return generate_probability_distribution(emission_distr)

###
# Helper function to generate a dictionary with instances of ProbabilityDist
#
# @param Dictionary<String, Dictionary<String, Number>>
# @return Dictionary<String, ProbabilityDist>
###
def generate_probability_distribution(probabilities):
    distr_map = {}
    for key in probabilities.keys():
        xk = [] # nominal values for the different tags (have to be int)
        pk = [] # probability values for the different tags
        mapping = {} # mapping from the nominal int values to the actual tag string for easy access later
        keys = list(probabilities[key].keys())
        if keys.count("total_words") != 0:
            keys.remove("total_words")
        for i in range(0, len(keys)):
            subkey = keys[i]
            xk.append(i)
            pk.append(probabilities[key][subkey]["prob"])
            mapping[i] = subkey
        distr_map[key] = ProbabilityDist((xk, pk), mapping)

    return distr_map

###
# Generate a list of tags given a list of words
#
# @param List<String>
# @return List<String>
###
def filter(word_list):
    tag_list = []
    #TODO: actually do shit
    return tag_list;

def viterbi(word_list):
    viterbi_tags = []
    #TODO: find most probable tag sequence (pick_max_probability will help)
    return viterbi_tags;

###
# Entry point for application
###
def main():
    word2tag_map, transition_dists, emission_dists = read_file()

    #Anwendungs Bsp.:
    word2tag = "Konkursgerüchte drücken Kurs der Amazon-Aktie".split(" ")
    tag2word = "NN VVFIN NN ART NN".split(" ")
    for word in word2tag:
        print(transition_dists[word2tag_map[word]].pick_value())
    print("\n")
    for tag in tag2word:
        print(emission_dists[tag].pick_value())
    print(emission_dists["ART"].stats())

if __name__ == '__main__':
    main()
