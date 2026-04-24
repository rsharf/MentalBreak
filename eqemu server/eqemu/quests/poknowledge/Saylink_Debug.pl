sub EVENT_SAY {
    if ($text =~ /hail/i) {
        # Menu of test cases
        quest::say("Saylink Debug Menu:");
        quest::say("  Say [test1] for plain text baseline");
        quest::say("  Say [test2] for quest::saylink test");
        quest::say("  Say [test3] for bracket auto-inject test");
        quest::say("  Say [test4] for client Message test");
        quest::say("  Say [test5] for mixed saylink + plain text");
        quest::say("  Say [test6] for multiple saylinks in one line");
        quest::say("  Say [test7] for raw hex dump of saylink body");
    }

    if ($text =~ /test1/i) {
        # TEST 1: Plain text, no saylinks at all
        quest::say("TEST1 RESULT: This is plain text with no saylinks.");
    }

    if ($text =~ /test2/i) {
        # TEST 2: quest::saylink() embedded in quest::say()
        my $link = quest::saylink("clickme", 0, "Click This Link");
        quest::say("TEST2 RESULT: Here is a saylink: " . $link);
    }

    if ($text =~ /test3/i) {
        # TEST 3: Bracket auto-injection via AutoInjectSaylinksToSay
        quest::say("TEST3 RESULT: Here is a bracket link: [BracketTest]");
    }

    if ($text =~ /test4/i) {
        # TEST 4: Use $client->Message() instead of quest::say()
        # This goes through OP_ColoredText or OP_SpecialMesg depending on type
        my $link = quest::saylink("clickme2", 0, "Click Via Message");
        $client->Message(257, "TEST4 RESULT (Message 257): Here is a saylink: " . $link);
        $client->Message(15, "TEST4 RESULT (Message 15): Here is a saylink: " . $link);
        $client->Message(10, "TEST4 RESULT (Message 10/NPCQuestSay): Here is a saylink: " . $link);

        # Also test ChannelMessage which uses OP_ChannelMessage
        # Type 8 = Say channel
        $client->Message(0, "TEST4 RESULT (Message 0): Here is a saylink: " . $link);
    }

    if ($text =~ /test5/i) {
        # TEST 5: Saylink mixed with surrounding text
        my $link = quest::saylink("option_a", 0, "Option A");
        quest::say("TEST5 RESULT: Choose " . $link . " or do nothing.");
    }

    if ($text =~ /test6/i) {
        # TEST 6: Multiple saylinks on one line
        my $link1 = quest::saylink("choice1", 0, "First");
        my $link2 = quest::saylink("choice2", 0, "Second");
        my $link3 = quest::saylink("choice3", 0, "Third");
        quest::say("TEST6 RESULT: Pick " . $link1 . " or " . $link2 . " or " . $link3);
    }

    if ($text =~ /test7/i) {
        # TEST 7: Dump the raw saylink string to see what Perl produces
        my $link = quest::saylink("debugdump", 0, "DebugLink");
        my $hex = unpack("H*", $link);
        quest::say("TEST7 raw hex of saylink: " . $hex);
        quest::say("TEST7 link length: " . length($link));
        quest::say("TEST7 the actual link: " . $link);
    }

    # Handle click responses from test saylinks
    if ($text =~ /clickme$/i) {
        quest::say("SUCCESS: You clicked the test2 saylink (clickme)!");
    }
    if ($text =~ /clickme2$/i) {
        quest::say("SUCCESS: You clicked the test4 saylink (clickme2)!");
    }
    if ($text =~ /option_a$/i) {
        quest::say("SUCCESS: You clicked Option A from test5!");
    }
    if ($text =~ /choice1$/i) {
        quest::say("SUCCESS: You clicked First from test6!");
    }
    if ($text =~ /choice2$/i) {
        quest::say("SUCCESS: You clicked Second from test6!");
    }
    if ($text =~ /choice3$/i) {
        quest::say("SUCCESS: You clicked Third from test6!");
    }
    if ($text =~ /debugdump$/i) {
        quest::say("SUCCESS: You clicked the debug dump link from test7!");
    }
    if ($text =~ /BracketTest$/i) {
        quest::say("SUCCESS: You clicked the bracket auto-inject link from test3!");
    }
}
