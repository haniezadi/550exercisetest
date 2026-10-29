DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: عدسی با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('عدسی با نان', 'compound', 'dinner', NULL, 'dinner:12:عدسی-با-نان', 'عدسی نسبتاً غلیظ، با پیاز و روغن کم، بدون سیب‌زمینی؛ هر ۱۰۰ گرم آماده حدود ۱۱۰ کالری / ۷ گرم پروتئین. روغن و پیاز داخل وزن عدسی حساب شده‌اند. عدسی خیلی رقیق در همین وزن، کالری و پروتئین کمتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدسی با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 22,
    'dinner:12:عدسی-با-نان:400', '[{"name":"عدسی آماده","amount":"۱۹۵ گرم","household":"۱۳ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدسی با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:12:عدسی-با-نان:450', '[{"name":"عدسی آماده","amount":"۱۹۵ گرم","household":"۱۳ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 25g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'عدسی با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 25,
    'dinner:12:عدسی-با-نان:500', '[{"name":"عدسی آماده","amount":"۱۹۵ گرم","household":"۱۳ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: لوبیا چیتی با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('لوبیا چیتی با نان', 'compound', 'dinner', NULL, 'dinner:13:لوبیا-چیتی-با-نان', 'خوراک لوبیا چیتی نسبتاً غلیظ، با رب، پیاز و روغن کم، بدون سیب‌زمینی؛ هر ۱۰۰ گرم آماده حدود ۱۱۰ کالری / ۶ گرم پروتئین. رب، پیاز و روغن محدود داخل وزن خوراک حساب شده‌اند. روغن اضافه روی غذا در این سهم نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا چیتی با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 20,
    'dinner:13:لوبیا-چیتی-با-نان:400', '[{"name":"خوراک لوبیا چیتی آماده","amount":"۱۹۵ گرم","household":"۱۳ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا چیتی با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 22,
    'dinner:13:لوبیا-چیتی-با-نان:450', '[{"name":"خوراک لوبیا چیتی آماده","amount":"۱۹۵ گرم","household":"۱۳ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا چیتی با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 24,
    'dinner:13:لوبیا-چیتی-با-نان:500', '[{"name":"خوراک لوبیا چیتی آماده","amount":"۱۹۵ گرم","household":"۱۳ قاشق غذاخوری سرصاف یا حدود ۱ کاسهٔ کوچک"},{"name":"نان","amount":"۸۰ گرم","household":"۲⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خوراک گوشت و سبزیجات با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خوراک گوشت و سبزیجات با نان', 'compound', 'dinner', NULL, 'dinner:15:خوراک-گوشت-و-سبزیجات-با-نان', 'گوشت کم‌چرب با سبزیجات غیرنشاسته‌ای مانند کدو، لوبیاسبز، قارچ و فلفل دلمه‌ای؛ بدون سیب‌زمینی و ذرت. سبزیجات داخل خوراک جدا از سالاد همراه ثابت هستند. گوشت پرچرب، سیب‌زمینی و ذرت جایگزین مستقیم مواد این محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک گوشت و سبزیجات با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 26,
    'dinner:15:خوراک-گوشت-و-سبزیجات-با-نان:400', '[{"name":"گوشت کم‌چرب پخته","amount":"۷۰ گرم","household":"حدود ¾ کف دست"},{"name":"سبزیجات پخته","amount":"۱۵۰ گرم","household":"حدود ۱ تا ۱½ لیوان خردشده"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک گوشت و سبزیجات با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 28,
    'dinner:15:خوراک-گوشت-و-سبزیجات-با-نان:450', '[{"name":"گوشت کم‌چرب پخته","amount":"۷۰ گرم","household":"حدود ¾ کف دست"},{"name":"سبزیجات پخته","amount":"۱۵۰ گرم","household":"حدود ۱ تا ۱½ لیوان خردشده"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک گوشت و سبزیجات با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 30,
    'dinner:15:خوراک-گوشت-و-سبزیجات-با-نان:500', '[{"name":"گوشت کم‌چرب پخته","amount":"۷۰ گرم","household":"حدود ¾ کف دست"},{"name":"سبزیجات پخته","amount":"۱۵۰ گرم","household":"حدود ۱ تا ۱½ لیوان خردشده"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
