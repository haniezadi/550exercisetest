DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: ماکارونی با گوشت چرخ‌کرده (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماکارونی با گوشت چرخ‌کرده', 'compound', 'lunch', NULL, 'lunch:21:ماکارونی-با-گوشت-چرخکرده', 'گوشت و روغن داخل وزن غذا هستند. معادل پیمانه به شکل ماکارونی وابسته است؛ برای ماکارونی رشته‌ای، قاشق سرصاف معیار مناسبی نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 165 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 165 کالری', 'compound', 'lunch', NULL,
    v_base_id, '165 کالری', 165, 10,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:165', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 27,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:450', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۲۵ گرم","household":"حدود ۱½ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 30,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:500', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۵۵ گرم","household":"حدود ۱⅔ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با گوشت چرخ‌کرده — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 33,
    'lunch:21:ماکارونی-با-گوشت-چرخکرده:550', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۸۵ گرم","household":"حدود ۱¾ تا ۲ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماکارونی با مرغ (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماکارونی با مرغ', 'compound', 'lunch', NULL, 'lunch:22:ماکارونی-با-مرغ', 'ماکارونی، مرغ ریش‌ریش، رب، پیاز و روغن کم؛ بدون خامه و پنیر. هر ۱۰۰ گرم آماده حدود ۱۵۵ کالری / ۱۰ گرم پروتئین. مرغ داخل وزن ماکارونی حساب شده است؛ نان و ته‌دیگ اضافه در این سهم نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 29,
    'lunch:22:ماکارونی-با-مرغ:450', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۴۰ گرم","household":"حدود ۱½ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 32g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 32,
    'lunch:22:ماکارونی-با-مرغ:500', '[{"name":"ماکارونی مخلوط آماده","amount":"۲۷۰ گرم","household":"حدود ۱¾ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماکارونی با مرغ — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 35,
    'lunch:22:ماکارونی-با-مرغ:550', '[{"name":"ماکارونی مخلوط آماده","amount":"۳۰۵ گرم","household":"حدود ۲ پیمانه"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: آبگوشت با نان (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('آبگوشت با نان', 'compound', 'lunch', NULL, 'lunch:24:آبگوشت-با-نان', 'بدون دنبه و با جداکردن چربی قابل‌مشاهده. مواد جدا ثبت شده‌اند؛ اگر آن‌ها را بکوبی، مجموع همین سهم‌ها مقدار گوشت‌کوبیدهٔ وعده است. نان تلیت‌شده، بخشی از همین سهم نان است؛ نانِ همراه گوشت‌کوبیده هم باید از همین مقدار برداشته شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 31g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 31,
    'lunch:24:آبگوشت-با-نان:450', '[{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"حدود ۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 33g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 33,
    'lunch:24:آبگوشت-با-نان:500', '[{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۴۵ گرم","household":"۱٫۵ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 34g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'آبگوشت با نان — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 34,
    'lunch:24:آبگوشت-با-نان:550', '[{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"نخود و لوبیای پخته","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"سیب‌زمینی پخته","amount":"۵۰ گرم","household":"نصف سیب‌زمینی کوچک"},{"name":"آبِ آبگوشت کم‌چرب","amount":"۱۵۰ گرم","household":"۱ کاسهٔ کوچک کم‌پُر"},{"name":"نان","amount":"۶۵ گرم","household":"کمی بیشتر از ۲ کف دست"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
