class PlainFormatter:
    def format(self, phrases):
        output = ""
        for word in phrases:
            size = len(word.morphs)
            output += f'{word.lex}\t'
            for idx, m in enumerate(word.morphs):
                delim = idx + 1 != size and '+' or ''
                output += f'{m.lex}/{m.tag}{delim}'
            output += '\n'
        return output