#!/usr/bin/python3
"""
Using Reddit's API to retrieve top post titles recursively
"""
import requests

after = None


def recurse(subreddit, hot_list=[]):
    """Return top post titles recursively."""
    global after
    headers = {'User-Agent': 'fragrant_role'}
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    params = {'after': after}
    results = requests.get(url, params=params, headers=headers,
                           allow_redirects=False)

    if results.status_code == 200:
        after_data = results.json().get("data").get("after")
        if after_data is not None:
            after = after_data
            recurse(subreddit, hot_list)
        all_titles = results.json().get("data").get("children")
        for title_ in all_titles:
            hot_list.append(title_.get("data").get("title"))
        return hot_list
    else:
        return None
