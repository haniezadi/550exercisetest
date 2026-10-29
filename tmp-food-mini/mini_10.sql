DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: قیمه با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('قیمه با برنج', 'compound', 'lunch', NULL, 'lunch:16:قیمه-با-برنج', 'اگر سیب‌زمینی می‌خواهی: حدود ۵۰ گرم سیب‌زمینی تنوری بدون روغن ≈ نصف سیب‌زمینی کوچک اضافه کن و ۳۵ گرم، یعنی ۳½ قاشق، از برنج کم کن. سیب‌زمینی سرخ‌شده نیازمند محاسبهٔ روغن جداست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 150 کالری', 'compound', 'lunch', NULL,
    v_base_id, '150 کالری', 150, 6,
    'lunch:16:قیمه-با-برنج:150', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 450 cal, 29g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 29,
    'lunch:16:قیمه-با-برنج:450', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"برنج","amount":"۷۰ گرم","household":"۷ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 30g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 30,
    'lunch:16:قیمه-با-برنج:500', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۱۰ گرم","household":"۱۱ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 31g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'قیمه با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 31,
    'lunch:16:قیمه-با-برنج:550', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۴۵ گرم","household":"۱۴½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خورشت فسنجان با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خورشت فسنجان با برنج', 'compound', 'lunch', NULL, 'lunch:19:خورشت-فسنجان-با-برنج', 'فسنجان با مرغ، بدون شکر و روغن اضافه. بخش خورشتی شامل گردو، رب انار و پیاز، بدون مرغ است؛ هر ۱۰۰ گرم حدود ۲۰۰ کالری / ۴ گرم پروتئین. نکته: میزان گردو و غلظت فسنجان تأثیر زیادی بر کالری دارد؛ این برآورد برای فسنجان خیلی غلیظ، پرگردو یا شیرین معتبر نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 35g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 35,
    'lunch:19:خورشت-فسنجان-با-برنج:450', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":"حدود ¾ کف دست"},{"name":"برنج","amount":"۶۰ گرم","household":"۶ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 36g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 36,
    'lunch:19:خورشت-فسنجان-با-برنج:500', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":null},{"name":"برنج","amount":"۱۰۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 37g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت فسنجان با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 37,
    'lunch:19:خورشت-فسنجان-با-برنج:550', '[{"name":"بخش خورشتی بدون مرغ","amount":"۸۰ گرم","household":"۵–۶ قاشق سرصاف"},{"name":"مرغ پخته","amount":"۸۰ گرم","household":null},{"name":"برنج","amount":"۱۴۰ گرم","household":"۱۴ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خورشت بادمجان با برنج (lunch)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خورشت بادمجان با برنج', 'compound', 'lunch', NULL, 'lunch:20:خورشت-بادمجان-با-برنج', 'بادمجان تنوری یا پخته با روغن کم، گوجه، رب و پیاز؛ هر ۱۵۰ گرم بخش خورشتی بدون گوشت حدود ۱۰۰ کالری / ۲ گرم پروتئین. بادمجان داخل همین ۱۵۰ گرم است، نه علاوه بر آن. برای بادمجان کامل، وزن‌کردن از معادل قاشقی دقیق‌تر است. بادمجان پرروغن کالری بیشتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 450 cal, 26g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 450 کالری', 'compound', 'lunch', NULL,
    v_base_id, '450 کالری', 450, 26,
    'lunch:20:خورشت-بادمجان-با-برنج:450', '[{"name":"بخش خورشتی شامل بادمجان، بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت کم‌چرب پخته","amount":"۶۰ گرم","household":"کمی بیشتر از ½ کف دست"},{"name":"برنج","amount":"۱۰۵ گرم","household":"۱۰½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 500 cal, 27g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 500 کالری', 'compound', 'lunch', NULL,
    v_base_id, '500 کالری', 500, 27,
    'lunch:20:خورشت-بادمجان-با-برنج:500', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۴۵ گرم","household":"۱۴½ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 550 cal, 28g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خورشت بادمجان با برنج — 550 کالری', 'compound', 'lunch', NULL,
    v_base_id, '550 کالری', 550, 28,
    'lunch:20:خورشت-بادمجان-با-برنج:550', '[{"name":"بخش خورشتی بدون گوشت","amount":"۱۵۰ گرم","household":"۱۰ قاشق سرصاف"},{"name":"گوشت پخته","amount":"۶۰ گرم","household":null},{"name":"برنج","amount":"۱۸۰ گرم","household":"۱۸ قاشق سرصاف"},{"name":"همراه ثابت","amount":"سالاد ۱۰۰ گرم + ماست ۱۰۰ گرم","household":null}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
