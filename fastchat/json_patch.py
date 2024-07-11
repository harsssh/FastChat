import json
import functools

def patch_json():
    original_dumps = json.dumps
    original_dump = json.dump

    @functools.wraps(original_dumps)
    def patched_dumps(*args, **kwargs):
        kwargs.setdefault('ensure_ascii', False)
        return original_dumps(*args, **kwargs)

    @functools.wraps(original_dump)
    def patched_dump(*args, **kwargs):
        kwargs.setdefault('ensure_ascii', False)
        return original_dump(*args, **kwargs)

    json.dumps = patched_dumps
    json.dump = patched_dump

patch_json()