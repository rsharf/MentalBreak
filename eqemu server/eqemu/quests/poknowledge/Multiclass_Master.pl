sub EVENT_SAY {
    my $class_count = $client->GetMulticlassCount();
    my $has_warrior = $client->HasClass(1);
    my $has_cleric = $client->HasClass(2);
    my $has_paladin = $client->HasClass(3);
    my $has_ranger = $client->HasClass(4);
    my $has_shadowknight = $client->HasClass(5);
    my $has_druid = $client->HasClass(6);
    my $has_monk = $client->HasClass(7);
    my $has_bard = $client->HasClass(8);
    my $has_rogue = $client->HasClass(9);
    my $has_shaman = $client->HasClass(10);
    my $has_necromancer = $client->HasClass(11);
    my $has_wizard = $client->HasClass(12);
    my $has_magician = $client->HasClass(13);
    my $has_enchanter = $client->HasClass(14);
    my $has_beastlord = $client->HasClass(15);
    my $has_berserker = $client->HasClass(16);

    if ($text =~ /hail/i) {
        my %class_names = (
            1 => "Warrior", 2 => "Cleric", 3 => "Paladin", 4 => "Ranger",
            5 => "Shadow Knight", 6 => "Druid", 7 => "Monk", 8 => "Bard",
            9 => "Rogue", 10 => "Shaman", 11 => "Necromancer", 12 => "Wizard",
            13 => "Magician", 14 => "Enchanter", 15 => "Beastlord", 16 => "Berserker",
        );
        my @current;
        for my $cid (sort keys %class_names) {
            push @current, $class_names{$cid} if $client->HasClass($cid);
        }
        my $class_list = @current ? join(", ", @current) : "none";
        quest::say("Greetings, $name. I am the Multiclass Master. You have $class_count of 3 classes: $class_list.");

        if ($class_count >= 3) {
            quest::say("You have already reached your maximum of three classes.");
            return;
        }

        my @available;
        push @available, "warrior" if !$has_warrior;
        push @available, "cleric" if !$has_cleric;
        push @available, "paladin" if !$has_paladin;
        push @available, "ranger" if !$has_ranger;
        push @available, "shadow knight" if !$has_shadowknight;
        push @available, "druid" if !$has_druid;
        push @available, "monk" if !$has_monk;
        push @available, "bard" if !$has_bard;
        push @available, "rogue" if !$has_rogue;
        push @available, "shaman" if !$has_shaman;
        push @available, "necromancer" if !$has_necromancer;
        push @available, "wizard" if !$has_wizard;
        push @available, "magician" if !$has_magician;
        push @available, "enchanter" if !$has_enchanter;
        push @available, "beastlord" if !$has_beastlord;
        push @available, "berserker" if !$has_berserker;

        if (@available) {
            my @links = map { "'$_'" } @available;
            quest::say("Choose a class to learn: " . join(", ", @links) . ".");
        } else {
            quest::say("No additional classes are available at this time.");
        }
    }

    if ($text =~ /^warrior$/i) {
        if ($has_warrior) {
            quest::say("You already have Warrior.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(1);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Warrior!");
            $client->Message(15, "You have gained a new multiclass: Warrior!");
        } elsif ($result == 2) {
            quest::say("You already have Warrior.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^cleric$/i) {
        if ($has_cleric) {
            quest::say("You already have Cleric.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(2);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Cleric!");
            $client->Message(15, "You have gained a new multiclass: Cleric!");
        } elsif ($result == 2) {
            quest::say("You already have Cleric.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^paladin$/i) {
        if ($has_paladin) {
            quest::say("You already have Paladin.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(3);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Paladin!");
            $client->Message(15, "You have gained a new multiclass: Paladin!");
        } elsif ($result == 2) {
            quest::say("You already have Paladin.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^ranger$/i) {
        if ($has_ranger) {
            quest::say("You already have Ranger.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(4);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Ranger!");
            $client->Message(15, "You have gained a new multiclass: Ranger!");
        } elsif ($result == 2) {
            quest::say("You already have Ranger.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^shadow knight$/i) {
        if ($has_shadowknight) {
            quest::say("You already have Shadow Knight.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(5);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Shadow Knight!");
            $client->Message(15, "You have gained a new multiclass: Shadow Knight!");
        } elsif ($result == 2) {
            quest::say("You already have Shadow Knight.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^druid$/i) {
        if ($has_druid) {
            quest::say("You already have Druid.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(6);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Druid!");
            $client->Message(15, "You have gained a new multiclass: Druid!");
        } elsif ($result == 2) {
            quest::say("You already have Druid.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^monk$/i) {
        if ($has_monk) {
            quest::say("You already have Monk.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(7);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Monk!");
            $client->Message(15, "You have gained a new multiclass: Monk!");
        } elsif ($result == 2) {
            quest::say("You already have Monk.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^bard$/i) {
        if ($has_bard) {
            quest::say("You already have Bard.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(8);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Bard!");
            $client->Message(15, "You have gained a new multiclass: Bard!");
        } elsif ($result == 2) {
            quest::say("You already have Bard.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
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

    if ($text =~ /^shaman$/i) {
        if ($has_shaman) {
            quest::say("You already have Shaman.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(10);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Shaman!");
            $client->Message(15, "You have gained a new multiclass: Shaman!");
        } elsif ($result == 2) {
            quest::say("You already have Shaman.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^necromancer$/i) {
        if ($has_necromancer) {
            quest::say("You already have Necromancer.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(11);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Necromancer!");
            $client->Message(15, "You have gained a new multiclass: Necromancer!");
        } elsif ($result == 2) {
            quest::say("You already have Necromancer.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^wizard$/i) {
        if ($has_wizard) {
            quest::say("You already have Wizard.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(12);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Wizard!");
            $client->Message(15, "You have gained a new multiclass: Wizard!");
        } elsif ($result == 2) {
            quest::say("You already have Wizard.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^magician$/i) {
        if ($has_magician) {
            quest::say("You already have Magician.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(13);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Magician!");
            $client->Message(15, "You have gained a new multiclass: Magician!");
        } elsif ($result == 2) {
            quest::say("You already have Magician.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    if ($text =~ /^enchanter$/i) {
        if ($has_enchanter) {
            quest::say("You already have Enchanter.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(14);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Enchanter!");
            $client->Message(15, "You have gained a new multiclass: Enchanter!");
        } elsif ($result == 2) {
            quest::say("You already have Enchanter.");
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

    if ($text =~ /^berserker$/i) {
        if ($has_berserker) {
            quest::say("You already have Berserker.");
            return;
        }
        if ($class_count >= 3) {
            quest::say("You have already selected all three classes.");
            return;
        }

        my $result = $client->GrantMulticlass(16);
        if ($result == 0) {
            quest::say("Congratulations! You have acquired the knowledge of the Berserker!");
            $client->Message(15, "You have gained a new multiclass: Berserker!");
        } elsif ($result == 2) {
            quest::say("You already have Berserker.");
        } elsif ($result == 3) {
            quest::say("You have already selected all three classes.");
        } elsif ($result == 4) {
            $client->Message(13, "Database error granting class. Check server logs.");
        }
    }

    # Verify and grant class AAs whenever they interact with the master
    my $full_mask = 0;
    my $bucket = $client->GetBucket("GestaltClasses");
    $full_mask = int($bucket) if ($bucket ne "");
    $full_mask |= (1 << ($client->GetClass() - 1));
    
    # 2(Clr), 3(Pal), 4(Rng), 5(SHD), 6(Dru), 8(Brd), 10(Shm), 11(Nec), 12(Wiz), 13(Mag), 14(Enc), 15(Bst)
    # 2^1+2^2+2^3+2^4+2^5+2^7+2^9+2^10+2^11+2^12+2^13+2^14 = 32446
    my $spellcaster_mask = 32446;
    if (($full_mask & $spellcaster_mask) > 0) {
        $client->GrantAlternateAdvancementAbility(347, 4, 1);
    }
    if (($full_mask & 128) > 0) {
        $client->GrantAlternateAdvancementAbility(212, 1, 1);
    }
}
