
--FROM DARK RP
rp_languages = {}
-- DO NOT remove the english language!, you can edit it though
rp_languages.english = {
not_allowed = "You are not allowed to do this.",
not_allowed_model = "You are not allowed to spawn this model",
too_much_money = "You have too much money, you can't have more than 2147483640 $",
plz_valid_anmount = "anmount not valid",
drop_money = "You dropped"
nomoney = "You have not enought money to affrod this"
slot_full = "All inventory slots are used"
}

rp_languages.french = {
not_allowed = "Vous n'avez pas le droit de faire sa.",
not_allowed_model = "Vous n'avez pas le droit de spawner se model",
too_much_money = "Vous avez trop d'argent, vous ne pouvez pas avoir plus de 2147483640 $",
plz_valid_anmount = "Montant non valide",
drop_money = "Vous avez jeter"
nomoney = "vous n'avez pas asser d'argent pour vous offrir ceci."
slot_full = "tout les slots de l'inventaire sont plein"
}

if not ConVarExists("rp_language") then
	CreateConVar("rp_language", "english", {FCVAR_ARCHIVE, FCVAR_REPLICATED})	
end
LANGUAGE = rp_languages[GetConVarString("rp_language")]
if not LANGUAGE then
	LANGUAGE = rp_languages["english"]--now hope people don't remove the english language ._.
end