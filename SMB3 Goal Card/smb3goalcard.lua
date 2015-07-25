local __title = "SMB3 Goal Cards";
local __version = "0.0.0.1";
local __description = "Make the SMB3 Goal Card act as it did in SMB3.";
local __author = "XNBlank";
local __url = "https://github.com/XNBlank";

local smbGoalCard_API = {} --instance

local card1 = -1; -- basically a bool. Checks if card is used
local card2 = -1;
local card3 = -1;
local cards = 0;
local goalcard = NPC(11);
local getframe = 0;
local gotcard = false;
local addCard = false;
local resPath = getSMBXPath() .. "\\LuaScriptsLib\\smb3goalcard"; --res path
local uicard = Graphics.loadImage(resPath .. "\\smb3card.png");
local mushroomcard = Graphics.loadImage(resPath .. "\\mushroom.png");
local flowercard = Graphics.loadImage(resPath .. "\\flower.png");
local starcard = Graphics.loadImage(resPath .. "\\star.png");

local curLivesCount = tonumber(mem(0x00B2C5AC, FIELD_DWORD));
local dataInstance = Data(Data.DATA_WORLD, true);

local levelFinished = false;

smbGoalCard_API.GUIPosition1 = {x = 650, y = 550}
smbGoalCard_API.GUIPosition2 = {x = 698, y = 550}
smbGoalCard_API.GUIPosition3 = {x = 746, y = 550}

function smbGoalCard_API.onInitAPI()
        gotcard = false;
        addCard = false;
        registerEvent(smbGoalCard_API, "onLoop", "onLoopOverride");
        registerEvent(smbGoalCard_API, "onLoad", "onLoadOverride");
        cards = tonumber(dataInstance:get("cards"));
		card1 = tonumber(dataInstance:get("card1"));
		card2 = tonumber(dataInstance:get("card2"));
		card3 = tonumber(dataInstance:get("card3"));

end

function smbGoalCard_API.onLoadOverride()
  

	if(card1 == 0) then
		Graphics.placeSprite(1, starcard, smbGoalCard_API.GUIPosition1.x, smbGoalCard_API.GUIPosition1.y);
	elseif(card1 == 1) then
		Graphics.placeSprite(1, mushroomcard, smbGoalCard_API.GUIPosition1.x, smbGoalCard_API.GUIPosition1.y);
	elseif(card1 == 2) then
		Graphics.placeSprite(1, flowercard, smbGoalCard_API.GUIPosition1.x, smbGoalCard_API.GUIPosition1.y);
	end

	if(card2 == 0) then
		Graphics.placeSprite(1, starcard, smbGoalCard_API.GUIPosition2.x, smbGoalCard_API.GUIPosition2.y);
	elseif(card2 == 1) then
		Graphics.placeSprite(1, mushroomcard, smbGoalCard_API.GUIPosition2.x, smbGoalCard_API.GUIPosition2.y);
	elseif(card2 == 2) then
		Graphics.placeSprite(1, flowercard, smbGoalCard_API.GUIPosition2.x, smbGoalCard_API.GUIPosition2.y);
	end

	if(card3 == 0) then
		Graphics.placeSprite(1, starcard, smbGoalCard_API.GUIPosition3.x, smbGoalCard_API.GUIPosition3.y);
	elseif(card3 == 1) then
		Graphics.placeSprite(1, mushroomcard, smbGoalCard_API.GUIPosition3.x, smbGoalCard_API.GUIPosition3.y);
	elseif(card3 == 2) then
		Graphics.placeSprite(1, flowercard, smbGoalCard_API.GUIPosition3.x, smbGoalCard_API.GUIPosition3.y);
	end

end

function smbGoalCard_API.onLoopOverride()

        temp = NPC.get(11, -1);

        if(temp == nil) then

        elseif(temp[1] ~= nil) then
        thiscard = (temp[1]:mem(0xE4, FIELD_WORD));
        -- Text.print(tostring(temp[1]:mem(0xE4, FIELD_WORD)), 0, 0);
        end

        --temp[0]:mem(0xE4, FIELD_WORD);


        Graphics.placeSprite(1,uicard,smbGoalCard_API.GUIPosition1.x,smbGoalCard_API.GUIPosition1.y, "", 2);
        Graphics.placeSprite(1,uicard,smbGoalCard_API.GUIPosition2.x,smbGoalCard_API.GUIPosition2.y, "", 2);
        Graphics.placeSprite(1,uicard,smbGoalCard_API.GUIPosition3.x,smbGoalCard_API.GUIPosition3.y, "", 2);

        smbGoalCard_API.drawGottenCards();
        
        if(Level.winState() > 0) then
            smbGoalCard_API.endLevel();

        end


end

function smbGoalCard_API.drawGottenCards()

	Text.print("Card 1 = " .. dataInstance:get("card1"), 0, 0);
	Text.print("Card 2 = " .. dataInstance:get("card2"), 0, 15);
	Text.print("Card 3 = " .. dataInstance:get("card3"), 0, 30);
	Text.print("Current Card = " .. tostring(thiscard), 0, 60);
	Text.print("Cards = " .. tostring(cards), 0, 75);

end

function smbGoalCard_API.endLevel()

        levelFinished = true;

        if(Level.winState() > 0) then

	        if (addCard == false) then
	        	if(cards == nil) then
	        		cards = 0;
	        	end
	        	
	        	if(cards >= 4) then
	        		cards = 0;
	        		addCard = true;
	        	elseif(cards < 3) then
	        		local newcard = 1;
	            	cards = cards + newcard;
	            	addCard = true;
	            end
	        end

                gotcard = true;

				if (card1 == nil) then
					card1 = -1;
				end
				if (card2 == nil) then
					card2 = -1;
				end
				if (card3 == nil) then
					card3 = -1;
				end


				if(cards == 1) then
					if(card1 < 0) then
						card1 = tonumber(thiscard);
						dCard1 = card1;
						dataInstance:set("card1", tostring(card1));
					end

					if(card1 == 0) then
						Graphics.placeSprite(1, starcard, smbGoalCard_API.GUIPosition1.x, smbGoalCard_API.GUIPosition1.y);
					elseif(card1 == 1) then
						Graphics.placeSprite(1, mushroomcard, smbGoalCard_API.GUIPosition1.x, smbGoalCard_API.GUIPosition1.y);
					elseif(card1 == 2) then
						Graphics.placeSprite(1, flowercard, smbGoalCard_API.GUIPosition1.x, smbGoalCard_API.GUIPosition1.y);
					end
				end

				if(cards == 2) then
					if(card2 < 0) then
						card2 = tonumber(thiscard);
						dCard2 = card2;
						dataInstance:set("card2", tostring(card2));
					end

					if(card2 == 0) then
						Graphics.placeSprite(1, starcard, smbGoalCard_API.GUIPosition2.x, smbGoalCard_API.GUIPosition2.y);
					elseif(card2 == 1) then
						Graphics.placeSprite(1, mushroomcard, smbGoalCard_API.GUIPosition2.x, smbGoalCard_API.GUIPosition2.y);
					elseif(card2 == 2) then
						Graphics.placeSprite(1, flowercard, smbGoalCard_API.GUIPosition2.x, smbGoalCard_API.GUIPosition2.y);
					end
				end

				if(cards == 3) then
					if(card3 < 0) then
						card3 = tonumber(thiscard);
						dCard3 = card3;
						dataInstance:set("card3", tostring(card3));
					end

					if(card3 == 0) then
						Graphics.placeSprite(1, starcard, smbGoalCard_API.GUIPosition3.x, smbGoalCard_API.GUIPosition3.y);
					elseif(card3 == 1) then
						Graphics.placeSprite(1, mushroomcard, smbGoalCard_API.GUIPosition3.x, smbGoalCard_API.GUIPosition3.y);
					elseif(card3 == 2) then
						Graphics.placeSprite(1, flowercard, smbGoalCard_API.GUIPosition3.x, smbGoalCard_API.GUIPosition3.y);
					end
				end

                Text.print("Got Card!", 280, 115)
                if(thiscard == 1) then
                        Graphics.placeSprite(1,mushroomcard,450,96, "", 2);
                        local dCard1 = tonumber(dataInstance:get("card1 "));
                elseif(thiscard == 2) then
                        Graphics.placeSprite(1,flowercard,450,96, "", 2);
                        local dCard2 = tonumber(dataInstance:get("card2 "));
                elseif(thiscard == 0) then
                        Graphics.placeSprite(1,starcard,450,96, "", 2);
                        local dCard3 = tonumber(dataInstance:get("card3 "));
                end

                
                
                
                
                if(cards == 1) then
                	Text.print("set card1 to " .. tostring(card1), 0, 45);
            	elseif(cards == 2) then
            		Text.print("set card2 to " .. tostring(card2), 0, 45);
        		elseif(cards == 3) then
        			Text.print("set card3 to " .. tostring(card3), 0, 45);
        		end

				dataInstance:set("cards", tostring(cards));

				dataInstance:save();
        end

end

return smbGoalCard_API;