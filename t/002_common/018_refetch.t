use t::Utils;
use Mock::Basic;
use Test::More;

TODO: {
todo_skip 'not yet...',0;
my $dbh = t::Utils->setup_dbh;
my $db = Mock::Basic->new({dbh => $dbh});
$db->setup_test_db;

subtest 'refetch' => sub {
    my $row = $db->insert('mock_basic',{
        id   => 1,
        name => 'perl',
    });
    isa_ok $row, 'DBIx::Skin::Row';
    is $row->name, 'perl';

    my $refetch_row = $row->refetch;
    isa_ok $refetch_row, 'DBIx::Skin::Row';
    is $refetch_row->name, 'perl';
};

done_testing;
};
