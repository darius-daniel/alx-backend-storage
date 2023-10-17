#!/usr/bin/env python3
"""
11. Where can I learn Python?
"""


def schools_by_topic(mongo_collection, topic):
    """
    Returns a list of schools having a particular topic
    """
    return [
        school for school in mongo_collection.find()
        if topic in school.get('topics')
    ]
