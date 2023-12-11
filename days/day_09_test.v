module days

fn test_day_nine() {
	run_tests(day_nine, [
		TestFixture{
			buffer: read_input(day: 9, version: 1)
			expected_part_one: '114'
			expected_part_two: '2'
		},
	])
}
