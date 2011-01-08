use t::Utils;
use Mock::Inflate;
use Mock::Inflate::Name;
use Test::More;

TODO: {
todo_skip 'not yet...',0;
my $dbh = t::Utils->setup_dbh;
my $db = Mock::Inflate->new({dbh => $dbh});
$db->setup_test_db;

subtest 'scalar data bug case' => sub {
    my $name = Mock::Inflate::Name->new(name => 'perl');

    my $row = $db->insert('mock_inflate',{
        id   => 1,
        name => 'azumakuniyuki',
    });

    isa_ok $row, 'DBIx::Skin::Row';
    isa_ok $row->name, 'Mock::Inflate::Name';
    is $row->name->name, 'azumakuniyuki_deflate';
};

done_testing;
};
