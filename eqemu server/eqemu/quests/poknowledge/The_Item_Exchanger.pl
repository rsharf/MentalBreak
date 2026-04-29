sub EVENT_SAY {
    if ($text=~/hail/i) {
        quest::say("Greetings, $name. I am the Item Exchanger. Hand me any piece of equipment " .
                   "that you are trained to wear through your multiclass studies, and I will bind it to " .
                   "your soul, magically altering its physical form so you can wield it. If you wish to " .
                   "trade a bound item away, simply hand it back to me to unbind it.");
    }
}

sub EVENT_ITEM {
    my @item_insts = (
        plugin::val('item1_inst'),
        plugin::val('item2_inst'),
        plugin::val('item3_inst'),
        plugin::val('item4_inst'),
    );

    foreach my $item_id (keys %itemcount) {
        next if $item_id == 0;

        my $count = $itemcount{$item_id};

        # 1. UNBINDING: handed item is already bound (ID >= 2000000) — return the original
        if ($item_id >= 2000000) {
            my $original_id = $item_id - 2000000;
            # Pass item as both handin AND required — CheckHandin removes it from m_hand_in so ReturnHandinItems skips it
            $npc->CheckHandin($client, { $item_id => $count }, { $item_id => $count }, @item_insts);
            for (1..$count) {
                quest::summonitem($original_id);
            }
            quest::say("The item has been restored to its original form.");
        }
        # 2. BINDING: normal item — find its instance and give the bound Ethernaut version
        else {
            # Locate the engine-provided item instance for this item ID
            my $item_inst = undef;
            foreach my $inst (@item_insts) {
                if ($inst && $inst->GetID() == $item_id) {
                    $item_inst = $inst;
                    last;
                }
            }

            if (!$item_inst) {
                quest::say("I could not read that item's properties. Please try again.");
                next; # Not consumed — AlwaysReturnHandins will return it
            }

            my $item_data = $item_inst->GetItem();
            my $classes   = $item_data->GetClasses();
            my $slots     = $item_data->GetSlots();
            my $races     = $item_data->GetRaces();

            # Only bind equippable gear that has a class or race restriction
            if ($slots > 0 && ($classes != 65535 || $races != 65535)) {

                # Build the player's full class mask (primary class + multiclasses)
                my $gestalt_str  = $client->GetBucket("GestaltClasses");
                my $gestalt_mask = ($gestalt_str ne "") ? int($gestalt_str) : 0;
                my $primary_bit  = 1 << ($client->GetClass() - 1);
                my $full_mask    = $gestalt_mask | $primary_bit;

                if (($classes & $full_mask) > 0) {
                    # Authorized — consume the original and give the bound version
                    my $bound_id = $item_id + 2000000;
                    # Pass item as both handin AND required — CheckHandin removes it from m_hand_in so ReturnHandinItems skips it
                    $npc->CheckHandin($client, { $item_id => $count }, { $item_id => $count }, @item_insts);
                    for (1..$count) {
                        quest::summonitem($bound_id);
                    }
                    quest::say("This item has been bound to your soul and resized to fit your form.");
                } else {
                    quest::say("You do not possess the training required to wield this item in any capacity.");
                    # Not consumed — AlwaysReturnHandins returns it automatically
                }
            } else {
                quest::say("This item does not require my services.");
                # Not consumed — AlwaysReturnHandins returns it automatically
            }
        }
    }
}
