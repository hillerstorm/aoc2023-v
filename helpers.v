module main

import net.http
import os

fn get_input(day int) !string {
	input_path := 'inputs/${day}.txt'
	if os.exists(input_path) {
		return os.read_file(input_path)!
	}

	println('Input file not found, downloading...')
	if !os.exists('.session') {
		return error('No .session file found, save value from Cookie header on your aoc page')
	}

	session := os.read_file('.session')!
	res := http.fetch(
		method: .get
		url: 'https://adventofcode.com/2023/day/${day}/input'
		cookies: {
			'session': session
		}
	)!

	if res.body.len == 0 {
		return error('Empty input')
	}

	println('Downloaded input, saving to disk')

	os.write_file(input_path, res.body)!

	return res.body
}
