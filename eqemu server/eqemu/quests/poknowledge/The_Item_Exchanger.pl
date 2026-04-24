use DBI;

sub EVENT_SAY {
    if ($text=~/hail/i) {
        quest::say("Greetings, $name. I am the Item Exchanger. Hand me any piece of equipment that you are trained to wear through your multiclass studies, and I will bind it to your soul, magically altering its physical form so you can wield it. If you wish to trade a bound item away, simply hand it back to me to unbind it.");
    }
}

sub EVENT_ITEM {
    my $dsn = "DBI:mysql:database=peq;host=127.0.0.1;port=3306";
    my $dbh = DBI->connect($dsn, "root", "1");
    
    if (!$dbh) {
        quest::say("I am having trouble connecting to my magical archives. Try again later.");
        plugin::return_items(\%itemcount);
        return;
    }

    foreach my $item_id (keys %itemcount) {
        next if $item_id == 0; # Ignore money or empty slots
        
        my $count = $itemcount{$item_id};
        
        # 1. UNBINDING (Item ID >= 2000000)
        if ($item_id >= 2000000) {
            my $original_id = $item_id - 2000000;
            # Give back original
            for (1..$count) {
                quest::summonitem($original_id);
            }
            quest::say("The item has been restored to its original form.");
            # Remove from hash so plugin::return_items doesn't give it back
            delete $itemcount{$item_id};
        }
        # 2. BINDING (Item ID < 2000000)
        else {
            # Check if this item is equippable and has restrictions
            my $query = "SELECT classes, slots, races FROM items WHERE id = ?";
            my $sth = $dbh->prepare($query);
            $sth->execute($item_id);
            
            if (my $row = $sth->fetchrow_hashref()) {
                my $classes = $row->{classes};
                my $slots = $row->{slots};
                my $races = $row->{races};
                
                # We only bind equippable gear that actually has a class/race restriction
                if ($slots > 0 && ($classes != 65535 || $races != 65535)) {
                    
                    # Verify multiclass authorization
                    my $gestalt_str = $client->GetBucket("GestaltClasses");
                    my $gestalt_mask = 0;
                    if ($gestalt_str ne "") {
                        $gestalt_mask = int($gestalt_str);
                    }
                    
                    # Always include primary class in their mask
                    # EQ classes are 1-indexed. Bitmask is 1 << (class - 1)
                    my $primary_class_bit = 1 << ($client->GetClass() - 1);
                    my $full_mask = $gestalt_mask | $primary_class_bit;
                    
                    # Check if the player has at least one of the item's required classes
                    if (($classes & $full_mask) > 0) {
                        # Authorized! Summon the bound version
                        my $bound_id = $item_id + 2000000;
                        for (1..$count) {
                            quest::summonitem($bound_id);
                        }
                        quest::say("This item has been bound to your soul and resized to fit your form.");
                        delete $itemcount{$item_id};
                    } else {
                        quest::say("You do not possess the training required to wield this item in any capacity.");
                        # Do not delete from itemcount; it will be returned
                    }
                } else {
                    quest::say("This item does not require my services.");
                    # Do not delete from itemcount
                }
            }
        }
    }
    
    $dbh->disconnect();
    
    # Return any items that weren't processed
    plugin::return_items(\%itemcount);
}
