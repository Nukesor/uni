# -*- coding: utf-8 -*-
#!/usr/bin/env python3
import functools
from collections import defaultdict


tag_relation = defaultdict(functools.partial(defaultdict, int))
word_tag_relation = defaultdict(functools.partial(defaultdict, int))


# Propability distribution class
# There is one instance for every tag, containing
# normalized propabilities for following tags.
class PropabilityDist():
    def __init__(self, tagList):
        self.dist = tagList
        self.normalize()

    def normalize(self):
        overall = sum(self.dist.values())
        if overall > 0: #<-- prevents divide by 0 error...not sure if makes sense though
            new_dist = {k: v/overall for k, v in self.dist.items()}
            self.dist = new_dist

    def max(self):
        return max(
            self.dist.keys(),
            key=(lambda key: self.dist[key])
        )

    def intersect(self, tagList):
        new_dist = {}
        for tag in self.dist:
            if tag in self.dist:
                new_dist[tag] = self.dist[tag]

        return PropabilityDist(new_dist)


def parse(training):
    previous_tag = ''
    for line in training:
        if line == '\n':
            previous_tag = ''
        else:
            word, tag = line.strip().split('\t')
            word_tag_relation[word][tag] += 1
            tag_relation[previous_tag][tag] += 1
            previous_tag = tag
    return tag_relation, word_tag_relation


def train(tag_relation):
    distributions = {}
    for tag, distribution in tag_relation.items():
        distributions[tag] = PropabilityDist(distribution)
    return distributions


def filter(_list, distributions):
    filtered = []
    previous_tag = ''
    for word in _list:
        if word in word_tag_relation:
            if len(filtered) == 0:
                # Choose the most common tag for the first word in a sentence
                tag = max(
                    word_tag_relation[word].keys(),
                    key=(lambda key: word_tag_relation[word][key])
                )
            else:
                # Intersect possible Tags for word with previous tag distribution
                tag = distributions[previous_tag].intersect(word_tag_relation[word])

            # Append word with tag to output list
            filtered.append((word, tag))
            # Set new previous tag
            previous_tag = tag
        else:
            filtered.append((word, None))

    for word in filtered:
        print(word[0], word[1])


def main():
    training = open('hdt-1-10000-train.tags', 'r')
    tag_relation, word_tag_relation = parse(training)
    distributions = train(tag_relation)

    input_txt = 'Nach Berichten von US-Agenturen und Nachrichtenmagazinen hat Bill Clinton die CIA zu einem Cyber-Krieg gegen den jugoslawischen Präsidenten Slobodan Milosevic ermächtigt .'.split(' ')
    filter(input_txt, distributions)


if __name__ == '__main__':
    main()
