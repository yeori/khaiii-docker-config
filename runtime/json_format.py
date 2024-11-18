import json

class JsonFormatter:
    def format(self, data):
        items = []
        for word in data:
            morphemes = []
            for morpheme in word.morphs:
                morphemes.append({'lex': morpheme.lex, 'tag': morpheme.tag})
            items.append({'phrase': word.lex, 'morphs': morphemes})
        return json.dumps(items, indent=2, ensure_ascii=False)