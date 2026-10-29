DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: لوبیا گرم و نان (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('لوبیا گرم و نان', 'compound', 'breakfast', NULL, 'breakfast:15:لوبیا-گرم-و-نان', 'خوراک لوبیا چیتی نسبتاً غلیظ با رب، پیاز و روغن کم؛ بدون سیب‌زمینی. حدود ۱۱۵ کالری و ۷ گرم پروتئین در ۱۰۰ گرم. روغن داخل همین برآورد لحاظ شده است. لیست نهار: مبنای اندازه‌گیری و محاسبه در تمام نسخه‌های زیر، این همراه در کالری و پروتئین کل حساب شده است:')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 350 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 350 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '350 کالری', 350, 18,
    'breakfast:15:لوبیا-گرم-و-نان:350', '[{"name":"خوراک لوبیا آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"آب‌لیمو و ادویه","amount":"به مقدار دلخواه، بدون شکر","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 400 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 400 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '400 کالری', 400, 20,
    'breakfast:15:لوبیا-گرم-و-نان:400', '[{"name":"خوراک لوبیا آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"آب‌لیمو و ادویه","amount":"به مقدار دلخواه، بدون شکر","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 450 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '450 کالری', 450, 22,
    'breakfast:15:لوبیا-گرم-و-نان:450', '[{"name":"خوراک لوبیا آماده","amount":"۲۰۰ گرم","household":"۱ پیمانه یا ۱ کاسهٔ متوسط کم‌پُر"},{"name":"نان","amount":"۸۵ گرم","household":"حدود ۳ کف دست"},{"name":"آب‌لیمو و ادویه","amount":"به مقدار دلخواه، بدون شکر","household":null},{"name":"سالاد","amount":"۱۰۰ گرم","household":"۱ لیوان خردشده"},{"name":"ماست کم‌چرب","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف یا ۱ کاسهٔ کوچک کم‌پُر"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 80 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'لوبیا گرم و نان — 80 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '80 کالری', 80, 5,
    'breakfast:15:لوبیا-گرم-و-نان:80', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کباب تابه‌ای با برنج یا نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کباب تابه‌ای با برنج یا نان', 'compound', 'lunch', NULL, 'lunch:1:کباب-تابهای-با-برنج-یا-نان', 'با انتخاب نان، پروتئین نسخه‌ها حدود ۳۳، ۳۵ و ۳۷ گرم است. نان و برنج، جایگزین یکدیگرند؛ نه اینکه هر دو مصرف شوند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 240 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 240 کالری', 'compound', 'lunch', NULL,
    v_base_id, '240 کالری', 240, 24,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:240', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 32,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:450', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"جایگزین برنج","amount":"نان ۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 33,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:500', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"برنج","amount":"۱۴۰ گرم","household":"۱۴ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 34g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با برنج یا نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 34,
    'lunch:1:کباب-تابهای-با-برنج-یا-نان:550', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"برنج","amount":"۱۸۰ گرم","household":"۱۸ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۹۰ گرم","household":"۳ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: جوجه‌کباب با نان یا برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('جوجه‌کباب با نان یا برنج', 'compound', 'lunch', NULL, 'lunch:2:جوجهکباب-با-نان-یا-برنج', 'جوجه از سینهٔ مرغ بدون پوست؛ بدون کرهٔ روی کباب. روغن نوشته‌شده، سهم کل پخت و مزه‌دارکردن همان وعده است. با نان، پروتئین نسخه‌ها حدود ۴۶، ۴۸ و ۵۰ گرم است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 45g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'جوجه‌کباب با نان یا برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 45,
    'lunch:2:جوجهکباب-با-نان-یا-برنج:450', '[{"name":"جوجه‌کباب پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان ۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 46g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'جوجه‌کباب با نان یا برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 46,
    'lunch:2:جوجهکباب-با-نان-یا-برنج:500', '[{"name":"جوجه‌کباب پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۳۵ گرم","household":"۱۳½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 47g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'جوجه‌کباب با نان یا برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 47,
    'lunch:2:جوجهکباب-با-نان-یا-برنج:550', '[{"name":"جوجه‌کباب پخته","amount":"۱۲۰ گرم","household":"۱ کف دست بزرگ"},{"name":"برنج","amount":"۱۷۵ گرم","household":"۱۷½ قاشق سرصاف"},{"name":"جایگزین برنج","amount":"نان حدود ۹۰ گرم","household":"۳ کف دست"},{"name":"روغن","amount":"۵ گرم","household":"۱ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
