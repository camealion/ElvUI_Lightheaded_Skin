if ElvUI then
	local E, L, DF = unpack(ElvUI)
	local S = E:GetModule('Skins')
	c = E
	--DEFAULT_CHAT_FRAME:AddMessage("ElvUI is loaded")
else
	local T, C, L = unpack(Tukui)
	c = C
	--DEFAULT_CHAT_FRAME:AddMessage("Tukui is loaded")
end
local LightHeaded = _G.LightHeaded

local function DoDis(self, event, ...)

	-- Quest Dude!
		QuestNPCModel:ClearAllPoints()
		QuestNPCModel:SetPoint("TOPLEFT", LightHeadedFrame, "TOPRIGHT", 5, -10)
		QuestNPCModel:SetAlpha(0.85)
		
	-- Move LH Frame
		LightHeadedFrame:Point("LEFT",  QuestLogFrame, "RIGHT", 2, 0)
			
end

local function SkinOptions(self, event, ...)-- Skin the Options Frame
		local lhp = _G["LightHeaded_Panel"]
		
			--if lhp:IsShown = true then	-- If option panels not open to the LH pagc
		if lhp:IsVisible() then
		
	-- Checkboxes
		for i = 1, 9 do
			local cbox = _G["LightHeaded_Panel_Toggle"..i]
			cSkinCheckBox(cbox)
		end
	
	-- Skin Buttons
		local buttons = {
			"LightHeaded_Panel_Button1",
			"LightHeaded_Panel_Button2",
			}
	
		for _, button in pairs(buttons) do
						cSkinButton(_G[button])
		end
		
		LightHeaded_Panel_Button2:Disable()
	
		local detachwarn = CreateFrame("Frame", "DetachWarning", LightHeaded_Panel)
				detachwarn:SetWidth(280)	
				detachwarn.title = detachwarn:CreateFontString(nil, "ARTWORK")
				detachwarn.title2 = detachwarn:CreateFontString(nil, "ARTWORK")
				detachwarn.title:SetFontObject(GameFontHighlight)
				detachwarn.title2:SetFontObject(GameFontHighlight)
				detachwarn.title:SetPoint("LEFT", LightHeaded_Panel_Button2, "RIGHT", 10, 5)
				detachwarn.title2:SetPoint("LEFT", LightHeaded_Panel_Button2, "RIGHT", 12, -7)
				detachwarn.title:SetText("Detach Mode is buggy with |cff1784d1ElvUI|r Lightheaded Skin!")
				detachwarn.title2:SetText("Type /lh detach to use at your own risk.")
	end
end

local SkinLightHeaded = CreateFrame("Frame")
	SkinLightHeaded:RegisterEvent("PLAYER_ENTERING_WORLD")
	SkinLightHeaded:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("Skinner") or IsAddOnLoaded("Aurora") then return end
	if not IsAddOnLoaded("LightHeaded") then return end
	
	local StripAllTextures = {
				"LightHeadedFrame",
				"LightHeadedFrameSub",
				"LightHeadedSearchBox",
				"LightHeadedTooltip",
				"LightHeadedScrollFrame",
				}

	local SetTemplateD = { -- Default Texture
				--"LightHeadedScrollFrame",l
				}

	local SetTemplateT = {-- Transparent Texture
				"LightHeadedFrame",
				"LightHeadedFrameSub",
				"LightHeadedSearchBox",
				"LightHeadedTooltip",
				}	

							
	for _, object in pairs(StripAllTextures) do
                _G[object]:StripTextures()
	end	

	for _, object in pairs(SetTemplateD) do
				_G[object]:SetTemplate("Default")
	end	

	for _, object in pairs(SetTemplateT) do
				_G[object]:SetTemplate("Transparent")
	end	
	
	-- Skin Close Button
		local lhframe = LightHeadedFrame		
		--cSkinCloseButton(lhframcclose) -- It's funky!
		lhframe.close:Hide() -- Lets just hide it! How many close buttons do we need? Besides I press "L"
		
	-- Hide that cool little close bar.  It causes problems.
		lhframe.handle:Hide()
	
	-- Skin Next/Previous Buttons
		local lhframe = LightHeadedFrameSub
		cSkinNextPrevButton(lhframe.prev)
		cSkinNextPrevButton(lhframe.next)
		
	-- Set Next/Previous Buttons size and locations (They move around!)
		lhframe.prev:SetWidth(16)
		lhframe.prev:SetHeight(16)
		lhframe.next:SetWidth(16)
		lhframe.next:SetHeight(16)
		lhframe.prev:SetPoint("RIGHT", lhframe.page, "LEFT", -25, 0)
		lhframe.next:SetPoint("LEFT", lhframe.page, "RIGHT", 25, 0)
	
	-- Skin Scrollbar	
		cSkinScrollBar(LightHeadedScrollFrameScrollBar, 5)
		
	--	Match ElvUI Blue!
		lhframe.title:SetTextColor(23/255, 132/255, 209/255)	
	
	-- Move when LH is shown.
		local LH_OnLoad = _G["LightHeadedFrame"]
        LH_OnLoad:SetScript("OnUpdate", DoDis)
		
	-- Checkboxes/Options Framc
		local LH_Options = _G["LightHeaded_Panel"]
        --LH_Options:SetScript("OnShow", SkinOptions) -- Buggy	
		
end)