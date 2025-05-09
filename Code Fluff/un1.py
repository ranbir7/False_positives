def reverse(s):
    return s if len(s) == 0 else reverse(s[1:]) + s[0]

print(reverse("hello"))  # "olleh"
