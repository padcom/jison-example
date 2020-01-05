#!/usr/bin/env node

const fs = require('fs')
const ebnf = require('ebnf-parser')
const Parser = require('jison').Parser

const source = fs.readFileSync('calc.jison').toString()
const grammar = ebnf.parse(source)
const parser = new Parser(grammar)

const expression = `-(a1 / (2 + 1)) + 456.1 * 7 / 10; a1 + 2;`
const ast = parser.parse(expression)

console.log('Grammar:', JSON.stringify(grammar, null, 2))
console.log('Expression:', expression)
console.log('AST:', JSON.stringify(ast, null, 2))
