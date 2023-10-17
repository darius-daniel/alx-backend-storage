#!/usr/bin/env python3
"""
8. List All Documents in Python
"""


def list_all(mongo_collection):
    """
    Lists all documents in a mongodb collection
    """
    return [doc for doc in mongo_collection.find()]
