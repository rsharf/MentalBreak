sub EVENT_SAY {
    my $class_count = $client->GetMulticlassCount();
    my $has_rogue = $client->HasClass(9);
    my $has_beastlord = $client->HasClass(15);

    if ($text =~ /hail/i) {
        quest::say("Greetings, $name. I am the Multiclass Master. You have $class_count of 3 classes.");

        if ($class_count >= 3) {
            quest::say("You have already reached your maximum of three classes.");
            return;
        }

        my @available;
        push @available, "rogue" if !$has_rogue;
        push @available, "beastlord" if !$has_beastlord;

        if (@available) {
            quest::say("Say '" . join("' or '", @available) . "' to learn a new class.");
        } else {
            quest::say("No additional classes are available at this time.");
        }
    }

    if ($text =~ /^rogue$/i) {
        if ($has_rogue) {
            quest::say("You already have Rogue.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(9);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Rogue!");
            $client->Message(15, "You have gained a new multiclass: Rogue!");
        } elsif ($result == 2) {
            quest::say("You already have Rogue.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^beastlord$/i) {
        if ($has_beastlord) {
            quest::say("You already have Beastlord.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(15);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Beastlord!");
            $client->Message(15, "You have gained a new multiclass: Beastlord!");
        } elsif ($result == 2) {
            quest::say("You already have Beastlord.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }
}
