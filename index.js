#!/usr/bin/env node

const fs = require('fs')
const ebnf = require('ebnf-parser')
const Parser = require('jison').Parser

const source = fs.readFileSync('calc.jison').toString()
const grammar = ebnf.parse(source)
const parser = new Parser(grammar)

const expression = '-(123.3 / 2) + 456.1 * 7 / 10'
const ast = parser.parse(expression)

console.log('Grammar:', JSON.stringify(grammar, null, 2))
console.log('Expression:', expression)
console.log('AST:', JSON.stringify(ast, null, 2))
