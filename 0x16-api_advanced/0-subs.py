#!/usr/bin/python3
"""
Reddit API Subscribers Query Function

This function queries the Reddit API and returns
the number of subscribers for a given subreddit.
If the subreddit is invalid, it returns 0.
"""


import requests


def number_of_subscribers(subreddit):
    """
    Get the number of subscribers for a given subreddit.

    Args:
    - subreddit (str): The subreddit to query.

    Returns:
    - int: Number of subscribers if the subreddit is valid, else 0.
    """
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {"User-Agent": "Custom User Agent"}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json()
        return data.get('data', {}).get('subscribers')
    else:
        return 0
