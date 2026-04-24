-- items: 84091, 84092, 84093, 6800
function event_spawn(e)
	eq.set_timer("shout",10 * 60 * 1000);
end

function event_say(e)
	if e.message:findi("trick or treat") then
		e.self:Say("Here I'll just wrap this up for you. . . Get it? Hahaha!");
		e.other:SummonItem(eq.ChooseRandom(84091,84092,84093,6800,6800,6800,6800,6800,6800,6800)); -- Item(s): Sand (84091), Chunk of Coal (84092), Pocket Lint (84093), Tasty Candy (6800), Tasty Candy (6800), Tasty Candy (6800), Tasty Candy (6800), Tasty Candy (6800), Tasty Candy (6800), Tasty Candy (6800)
		eq.update_task_activity(500220,9,1);
	end
end

function event_timer(e)
	if e.timer == "shout" then
		e.self:Shout("Trick or treat! Smell my feet! Give me something good to eat!");
	end
end

-- Auto-generated Fabled Controller Script
-- Wraps_McGee (36098) Spawns #The_Fabled_Wraps_McGee (ID: 36101) exactly 15 seconds after death

function event_death_complete(e)
    -- ID 999999 is our invisible Fabled_Spawner controller
    local spawner = eq.spawn2(999999, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading())
    if spawner and spawner.valid then
        spawner:CastToNPC():SetEntityVariable("fabled_id", "36101")
    end
end
