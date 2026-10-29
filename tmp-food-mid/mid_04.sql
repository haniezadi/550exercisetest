DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  
  -- Base food: خوراک مرغ و قارچ با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خوراک مرغ و قارچ با نان', 'compound', 'dinner', NULL, 'dinner:5:خوراک-مرغ-و-قارچ-با-نان', 'بدون خامه، پنیر و کره؛ مرغ و قارچ جدا وزن می‌شوند. روغن نوشته‌شده، کل سهم روغن پخت همین وعده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 42g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 42,
    'dinner:5:خوراک-مرغ-و-قارچ-با-نان:400', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 43g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 43,
    'dinner:5:خوراک-مرغ-و-قارچ-با-نان:450', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 45g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خوراک مرغ و قارچ با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 45,
    'dinner:5:خوراک-مرغ-و-قارچ-با-نان:500', '[{"name":"مرغ پخته","amount":"۱۰۰ گرم","household":"۱ کف دست"},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"پیاز پخته","amount":"۲۰ گرم","household":"۱ قاشق غذاخوری پُر"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کباب تابه‌ای با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کباب تابه‌ای با نان', 'compound', 'dinner', NULL, 'dinner:6:کباب-تابهای-با-نان', 'گوشت چرخ‌کرده نسبتاً کم‌چرب و پیاز، بدون روغن اضافه؛ هر ۱۰۰ گرم آماده حدود ۲۴۰ کالری / ۲۴ گرم پروتئین. کباب تهیه‌شده با گوشت پرچرب یا روغن اضافه، کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 32,
    'dinner:6:کباب-تابهای-با-نان:400', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"نان","amount":"۳۰ گرم","household":"۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 33,
    'dinner:6:کباب-تابهای-با-نان:450', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"نان","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کباب تابه‌ای با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 35,
    'dinner:6:کباب-تابهای-با-نان:500', '[{"name":"کباب تابه‌ای","amount":"۱۰۰ گرم","household":"۱ کف دست یا ۲ قطعهٔ ۵۰ گرمی"},{"name":"نان","amount":"۷۰ گرم","household":"۲⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کوکوی سبزی با نان و ماست (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کوکوی سبزی با نان و ماست', 'compound', 'dinner', NULL, 'dinner:7:کوکوی-سبزی-با-نان-و-ماست', 'سبزی، تخم‌مرغ و روغن محدود؛ بدون گردو و زرشک افزوده. هر ۱۰۰ گرم آماده حدود ۱۷۰ کالری / ۱۰ گرم پروتئین. ماستِ عنوان غذا همان ۱۰۰ گرم ماست همراه ثابت است، نه علاوه بر آن. تخم‌مرغ و روغن پخت داخل وزن کوکو حساب شده‌اند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی با نان و ماست — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 22,
    'dinner:7:کوکوی-سبزی-با-نان-و-ماست:400', '[{"name":"کوکوی سبزی آماده","amount":"۱۵۰ گرم","household":"۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی با نان و ماست — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:7:کوکوی-سبزی-با-نان-و-ماست:450', '[{"name":"کوکوی سبزی آماده","amount":"۱۵۰ گرم","household":"۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سبزی با نان و ماست — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 26,
    'dinner:7:کوکوی-سبزی-با-نان-و-ماست:500', '[{"name":"کوکوی سبزی آماده","amount":"۱۵۰ گرم","household":"۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کوکوی سیب‌زمینی با نان و ماست (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کوکوی سیب‌زمینی با نان و ماست', 'compound', 'dinner', NULL, 'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست', 'سیب‌زمینی، تخم‌مرغ و روغن محدود؛ هر ۱۰۰ گرم آماده حدود ۱۷۰ کالری / ۶ گرم پروتئین. سیب‌زمینی، تخم‌مرغ و روغن داخل وزن کوکو هستند. ماست دوباره اضافه نمی‌شود؛ کوکوی پرروغن کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سیب‌زمینی با نان و ماست — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 16,
    'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست:400', '[{"name":"کوکوی سیب‌زمینی آماده","amount":"۱۵۰ گرم","household":"۲ عدد یا ۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 18g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سیب‌زمینی با نان و ماست — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 18,
    'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست:450', '[{"name":"کوکوی سیب‌زمینی آماده","amount":"۱۵۰ گرم","household":"۲ عدد یا ۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کوکوی سیب‌زمینی با نان و ماست — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 20,
    'dinner:8:کوکوی-سیبزمینی-با-نان-و-ماست:500', '[{"name":"کوکوی سیب‌زمینی آماده","amount":"۱۵۰ گرم","household":"۲ عدد یا ۲ قطعهٔ متوسطِ ۷۵ گرمی"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: کتلت با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کتلت با نان', 'compound', 'dinner', NULL, 'dinner:9:کتلت-با-نان', 'کتلت فرپز یا تابه‌ای با روغن محدود؛ هر ۱۰۰ گرم آماده حدود ۱۸۰ کالری / ۱۰ گرم پروتئین. در این گزینه نسبت به ساندویچ کتلت، سهم کتلت بیشتر و نان کمتر است. روغن محدود پخت داخل برآورد کتلت لحاظ شده است. کتلت سرخ‌شده در روغن فراوان، جایگزین مستقیم این نسخه نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کتلت با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 22,
    'dinner:9:کتلت-با-نان:400', '[{"name":"کتلت آماده","amount":"۱۵۰ گرم","household":"۳ عدد کوچکِ ۵۰ گرمی یا ۲ عدد بزرگِ ۷۵ گرمی"},{"name":"نان","amount":"۲۰ گرم","household":"⅔ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 23g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کتلت با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 23,
    'dinner:9:کتلت-با-نان:450', '[{"name":"کتلت آماده","amount":"۱۵۰ گرم","household":"۳ عدد کوچکِ ۵۰ گرمی یا ۲ عدد بزرگِ ۷۵ گرمی"},{"name":"نان","amount":"۴۰ گرم","household":"۱⅓ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 25g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کتلت با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 25,
    'dinner:9:کتلت-با-نان:500', '[{"name":"کتلت آماده","amount":"۱۵۰ گرم","household":"۳ عدد کوچکِ ۵۰ گرمی یا ۲ عدد بزرگِ ۷۵ گرمی"},{"name":"نان","amount":"۶۰ گرم","household":"۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: املت گوجه‌فرنگی با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('املت گوجه‌فرنگی با نان', 'compound', 'dinner', NULL, 'dinner:10:املت-گوجهفرنگی-با-نان', 'تخم‌مرغ و گوجه‌فرنگی با روغن اندازه‌گیری‌شده؛ بدون کره و پنیر. گوجهٔ داخل املت جدا از سبزیجات همراه ثابت است. روغن نوشته‌شده، کل سهم روغن پخت وعده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 22g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت گوجه‌فرنگی با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 22,
    'dinner:10:املت-گوجهفرنگی-با-نان:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"گوجه‌فرنگی","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 24g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت گوجه‌فرنگی با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 24,
    'dinner:10:املت-گوجهفرنگی-با-نان:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"گوجه‌فرنگی","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت گوجه‌فرنگی با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 26,
    'dinner:10:املت-گوجهفرنگی-با-نان:500', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"گوجه‌فرنگی","amount":"۱۰۰ گرم","household":"۱ عدد کوچک"},{"name":"نان","amount":"۸۵ گرم","household":"کمی کمتر از ۳ کف دست"},{"name":"روغن","amount":"۴ گرم","household":"حدود ¾ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: املت قارچ با نان (dinner)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('املت قارچ با نان', 'compound', 'dinner', NULL, 'dinner:11:املت-قارچ-با-نان', 'تخم‌مرغ و قارچ با روغن محدود؛ بدون خامه، کره و پنیر. وزن قارچ مربوط به حالت پخته است. افزودن پنیر، کره یا خامه نیازمند محاسبهٔ جداگانه است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 400 cal, 25g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت قارچ با نان — 400 کالری', 'compound', 'dinner', NULL,
    v_base_id, '400 کالری', 400, 25,
    'dinner:11:املت-قارچ-با-نان:400', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت قارچ با نان — 450 کالری', 'compound', 'dinner', NULL,
    v_base_id, '450 کالری', 450, 27,
    'dinner:11:املت-قارچ-با-نان:450', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'املت قارچ با نان — 500 کالری', 'compound', 'dinner', NULL,
    v_base_id, '500 کالری', 500, 28,
    'dinner:11:املت-قارچ-با-نان:500', '[{"name":"تخم‌مرغ","amount":"۲ عدد متوسط","household":null},{"name":"قارچ پخته","amount":"۱۰۰ گرم","household":"حدود ۱ لیوان کم‌پُر خردشده"},{"name":"نان","amount":"۸۵ گرم","household":"کمی کمتر از ۳ کف دست"},{"name":"روغن","amount":"۳ گرم","household":"کمی بیشتر از ½ قاشق چای‌خوری"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

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
