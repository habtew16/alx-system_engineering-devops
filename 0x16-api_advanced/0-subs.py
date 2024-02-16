#!/usr/bin/python3
"""Module for task 0"""


def number_of_subscribers(subreddit):
    """Queries the Reddit API and returns the number of subscribers
    to the subreddit"""
    import requests

    get_url = requests.get("https://www.reddit.com/r/{}/about.json"
                            .format(subreddit),
                            headers={"User-Agent": "fragrant_role"},
                            allow_redirects=False)
    if get_url.status_code >= 300:
        return 0

    return get_url.json().get("data").get("subscribers")
