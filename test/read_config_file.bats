#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

@test "Check for 'tests/configs' directory" {
	run stat ${BATS_TEST_DIRNAME}/configs
	[ $status = 0 ]
}

@test "nonexistent configuration file" {
    run test/read_config_file_stub.sh "${BATS_TEST_DIRNAME}/configs/config_file_does_not_exist.conf"
    assert_failure
    assert_output --partial "Did not find config file"
}

@test "config variable backup_base gets trimmed" {
    skip
    source "${BATS_TEST_DIRNAME}/../includes/globals"
    source "${BATS_TEST_DIRNAME}/../includes/config_error" 
    read_config_file ${BATS_TEST_DIRNAME}/configs/read_config_file_trims_and_variables.conf
    result=${Configuration[backup_base]}
    [ "$result" == "/etc" ]
}