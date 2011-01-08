use t::Utils;
use Mock::Basic;
use Test::More;

TODO: {
todo_skip 'not yet...',0;
my $dbh = t::Utils->setup_dbh;
my $db = Mock::Basic->new({dbh => $dbh});
$db->setup_test_db;

subtest 'find_or_create' => sub {
    my $mock_basic = $db->find_or_create('mock_basic',{
        id   => 1,
        name => 'perl',
    });
    is $mock_basic->name, 'perl';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    $mock_basic = $db->find_or_create('mock_basic',{
        id   => 1,
        name => 'perl',
    });
    is $mock_basic->name, 'perl';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    is +$db->count('mock_basic', 'id',{name => 'perl'}), 1;
};

subtest 'find_or_insert' => sub {
    my $mock_basic = $db->find_or_insert('mock_basic',{
        id   => 2,
        name => 'ruby',
    });
    is $mock_basic->name, 'ruby';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    $mock_basic = $db->find_or_insert('mock_basic',{
        id   => 2,
        name => 'ruby',
    });
    is $mock_basic->name, 'ruby';
    is $mock_basic->delete_fg, 0, 'not specified column data should be got';

    is +$db->count('mock_basic', 'id',{name => 'ruby'}), 1;
};

subtest 'find_or_create' => sub {
    $db->delete('mock_basic');
    local $SIG{__WARN__} = sub{};
    eval {
        $db->find_or_create('mock_basic',{
            id   => 3,
            name => \' = "ruby"',
        });
    };
    ok $@;
};

done_testing;

}
