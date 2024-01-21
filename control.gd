extends Control

var ProductMade
var Money
var Supply
var AutoOwned
var AutoSupplyOwned

var Button_MakeProduct
var Button_BuySupply
var Button_BuyAutoMake
var Button_Auto10
var Button_Auto100
var Button_BuyAutoSupply
var Button_Sup10
var Button_Sup100

var CurrentTime = Time.get_time_string_from_system()
var MsTick1 = str(Time.get_ticks_msec()).split()[-3]

func _ready():
	ProductMade = get_node("MarginContainer/VBoxContainer/Row2/ProductMade")
	Money = get_node("MarginContainer/VBoxContainer/Row3/Money")
	Supply = get_node("MarginContainer/VBoxContainer/Row4/Supply")
	AutoOwned = get_node("MarginContainer/VBoxContainer/Row90/AutoOwned")
	AutoSupplyOwned = get_node("MarginContainer/VBoxContainer/Row91/AutoSupplyOwned")
	
	Button_MakeProduct = get_node("MarginContainer/VBoxContainer/Row1/MakeProduct")
	Button_BuySupply = get_node("MarginContainer/VBoxContainer/Row1/BuySupply")
	Button_BuyAutoMake = get_node("MarginContainer/VBoxContainer/Row90/BuyAutoMake")
	Button_Auto10 = get_node("MarginContainer/VBoxContainer/Row90/Auto10")
	Button_Auto100 = get_node("MarginContainer/VBoxContainer/Row90/Auto100")
	Button_BuyAutoSupply = get_node("MarginContainer/VBoxContainer/Row91/BuyAutoSupply")
	Button_Sup10 = get_node("MarginContainer/VBoxContainer/Row91/Sup10")
	Button_Sup100 = get_node("MarginContainer/VBoxContainer/Row91/Sup100")
	
	#var Number1 = 12345
	#print((str(Number1).split())[-3])



func _process(delta):
	var CurrentTime2 = Time.get_time_string_from_system()
	var MsTick2 = str(Time.get_ticks_msec()).split()[-3]
	
	if CurrentTime!=CurrentTime2:
	#	print(CurrentTime2)
		AutoRun()
	
	if MsTick1!=MsTick2:
		ButtonChecks()
		#print(MsTick2)
	
	CurrentTime = CurrentTime2
	MsTick1=MsTick2


# ==== Value Conversions
func MoneyOwned():
	var MoneyString = Money.get_text()
	MoneyString.replace("$","")
	MoneyString = int(MoneyString)
	return MoneyString

func NodeConversion(NodeObject):
	var StringItem = NodeObject.get_text()
	StringItem = int(StringItem)
	return StringItem

# ==== Buy Functions
func MakeProduct():
	var ProductsNum = NodeConversion(ProductMade)
	var MoneyValue = MoneyOwned()
	var SupplyNum = NodeConversion(Supply)
	if SupplyNum > 0:
		MoneyValue = "$" + str(MoneyValue+1)
		SupplyNum = str(SupplyNum-1)
		ProductsNum = str(ProductsNum+1)
		Money.set_text(MoneyValue)
		Supply.set_text(SupplyNum)
		ProductMade.set_text(ProductsNum)

func AutoMakeProduct():
	var AutoOwnVal = NodeConversion(AutoOwned)
	var ProductsNum = NodeConversion(ProductMade)
	var MoneyValue = MoneyOwned()
	var SupplyNum = NodeConversion(Supply)
	if SupplyNum >= AutoOwnVal:
		MoneyValue = "$" + str(MoneyValue+AutoOwnVal)
		SupplyNum = str(SupplyNum-AutoOwnVal)
		ProductsNum = str(ProductsNum+AutoOwnVal)
		Money.set_text(MoneyValue)
		Supply.set_text(SupplyNum)
		ProductMade.set_text(ProductsNum)

func BuySupply():
	var MoneyValue = MoneyOwned()
	var SupplyNum = NodeConversion(Supply)
	if MoneyValue >= 10:
		MoneyValue = "$" + str(MoneyValue-10)
		SupplyNum = str(SupplyNum+1000)
		Money.set_text(MoneyValue)
		Supply.set_text(SupplyNum)

func AutoBuySupply():
	var AutoOwnSupVal = NodeConversion(AutoSupplyOwned)
	var MoneyValue = MoneyOwned()
	var SupplyNum = NodeConversion(Supply)
	if (AutoOwnSupVal>0) and (MoneyValue >= (10 * AutoOwnSupVal)):
		MoneyValue = "$" + str(MoneyValue-(10 * AutoOwnSupVal))
		SupplyNum = str(SupplyNum+(1000 * AutoOwnSupVal))
		Money.set_text(MoneyValue)
		Supply.set_text(SupplyNum)

func BuyAutoMake():
	var MoneyValue = MoneyOwned()
	var AutoOwnVal = NodeConversion(AutoOwned)
	if MoneyValue >= 100:
		MoneyValue = "$" + str(MoneyValue-100)
		AutoOwnVal = str(AutoOwnVal+1)
		Money.set_text(MoneyValue)
		AutoOwned.set_text(AutoOwnVal)

func BuyAutoSupply():
	var MoneyValue = MoneyOwned()
	var AutoSupOwnVal = NodeConversion(AutoSupplyOwned)
	if MoneyValue >= 10000:
		MoneyValue = "$" + str(MoneyValue-10000)
		AutoSupOwnVal = str(AutoSupOwnVal+1)
		Money.set_text(MoneyValue)
		AutoSupplyOwned.set_text(AutoSupOwnVal)

# Auto Run Functions
func AutoRun():
	AutoBuySupply()
	AutoMakeProduct()

func ButtonChecks():
	var MoneyValue = MoneyOwned()
	var SupplyNum = NodeConversion(Supply)
	
	if SupplyNum > 0:
		Button_MakeProduct.set_disabled(false)
	else:
		Button_MakeProduct.set_disabled(true)
	
	if MoneyValue >= 10:
		Button_BuySupply.set_disabled(false)
	else:
		Button_BuySupply.set_disabled(true)
	
	if MoneyValue >= 100:
		Button_BuyAutoMake.set_disabled(false)
	else:
		Button_BuyAutoMake.set_disabled(true)
	
	if MoneyValue >= 1000:
		Button_Auto10.set_disabled(false)
	else:
		Button_Auto10.set_disabled(true)
	
	if MoneyValue >= 10000:
		Button_BuyAutoSupply.set_disabled(false)
		Button_Auto100.set_disabled(false)
	else:
		Button_BuyAutoSupply.set_disabled(true)
		Button_Auto100.set_disabled(true)
	
	if MoneyValue >= 100000:
		Button_Sup10.set_disabled(false)
	else:
		Button_Sup10.set_disabled(true)
	
	if MoneyValue >= 1000000:
		Button_Sup100.set_disabled(false)
	else:
		Button_Sup100.set_disabled(true)


# Buttons
func _on_make_product_pressed():
	MakeProduct()

func _on_buy_supply_pressed():
	BuySupply()

func _on_buy_auto_make_pressed():
	BuyAutoMake()

func _on_auto_10_pressed():
	var cnt=0
	while cnt < 10:
		BuyAutoMake()
		cnt=cnt+1

func _on_auto_100_pressed():
	var cnt=0
	while cnt < 100:
		BuyAutoMake()
		cnt=cnt+1

func _on_buy_auto_supply_pressed():
	BuyAutoSupply()
func _on_sup_10_pressed():
	var cnt=0
	while cnt < 10:
		BuyAutoSupply()
		cnt=cnt+1
func _on_sup_100_pressed():
	var cnt=0
	while cnt < 100:
		BuyAutoSupply()
		cnt=cnt+1










func _on_exit_pressed():
	get_tree().quit()
