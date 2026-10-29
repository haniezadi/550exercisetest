DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

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

END $$;
