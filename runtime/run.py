from khaiii import KhaiiiApi
import sys
import os
import locale

api = KhaiiiApi()
ws_dir = os.path.abspath('/ws')
res_file_path = os.path.join(ws_dir, 'res.txt')

print(f"encoding: {sys.stdin.encoding}")
print(f"Locale encoding: {locale.getpreferredencoding()}")

if len(sys.argv) > 0:
    sentence = ' '.join(sys.argv[1:])
    sentence = sentence.encode('utf-8').decode()
else:
    sentence = '형태소 분석기입니다.'
print(sentence)
with open(res_file_path, 'w', encoding='utf-8') as f:
    for word in api.analyze(sentence):
        size = len(word.morphs)
        f.write(f'{word.lex}\t')
        for idx, m in enumerate(word.morphs):
            delim = idx + 1 != size and '+' or ''
            # s = m.begin
            # e = s + m.length
            f.write(f'{m.lex}/{m.tag}{delim}')
        f.write('\n')