#!/usr/bin/env python3
"""Module containing classes"""
import redis
import uuid
from typing import Any, Union, Callable, Optional
from functools import wraps


def count_calls(method: Callable) -> Callable:
    """
    Counts the number of times methods of the Cache class are called
    """
    @wraps(method)
    def wrapper(self, *args, **kwargs) -> Any:
        """
        Increments the count for that key every time the method is called
        and returns the value returned by the original method.
        """
        if isinstance(self._redis, redis.Redis):
            self._redis.incr(method.__qualname__)
        return method(self, *args, **kwargs)

    return wrapper


def call_history(method: Callable) -> Callable:
    """
    Stores the history of inputs and outputs for a particular function
    """
    in_key = method.__qualname__ + ":inputs"
    out_key = method.__qualname__ + ":outputs"

    @wraps(method)
    def wrapper(self, *args) -> Any:
        self._redis.rpush(in_key, str(args))
        output = method(self, *args)
        self._redis.rpush(out_key, str(output))

        return output

    return wrapper


class Cache:
    """A Cache class"""
    def __init__(self) -> None:
        """
        Initialises a new Cache instance by storing a new instance of the
        Redis client as a private variable _redis
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    @count_calls
    @call_history
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Generates a random key
        """
        key = uuid.uuid4()
        self._redis.mset({str(key): data})
        return str(key)

    def get(self, key: str,
            fn: Optional[Callable] = None) -> Union[str, int, None]:
        """Performs some operation"""
        if fn is None:
            return self._redis.get(key)

        return fn(self._redis.get(key))

    def get_str(self, key: str) -> Union[str, int, None]:
        """
        Automatically parametrize Cache.get() with the str function
        """
        return self.get(key, str)

    def get_int(self, key: str) -> Union[str, int, None]:
        """
        Automatically parameterize Cache.get() with the int function
        """
        return self.get(key, int)
