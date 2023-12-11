module days

fn test_day_one() {
	run_tests(day_one, [
		TestFixture{
			buffer: read_input(day: 1)
			expected_part_one: '142'
		},
		TestFixture{
			buffer: read_input(day: 1, version: 2)
			expected_part_two: '281'
		},
	])
}
