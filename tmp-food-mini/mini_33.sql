DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: سیب‌زمینی آب‌پز یا کبابی (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سیب‌زمینی آب‌پز یا کبابی', 'compound', 'snack', 'filling', 'snack:15:سیبزمینی-آبپز-یا-کبابی', 'سیب‌زمینی بدون روغن و کره. به‌دلیل تفاوت آبِ باقی‌مانده، وزن سیب‌زمینی آب‌پز و کبابی برای کالری یکسان کمی متفاوت است. فقط یکی از دو روش انتخاب می‌شود؛ هر دو سهم با هم مصرف نمی‌شوند. این گزینه در دستهٔ درخواستی شما آمده، اما نسبت به میان‌وعده‌های دارای تخم‌مرغ یا ماست یونانی، پروتئین کمتری دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب‌زمینی آب‌پز یا کبابی — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 4,
    'snack:15:سیبزمینی-آبپز-یا-کبابی:150', '[{"name":"سیب‌زمینی آب‌پز","amount":"۱۷۰ گرم","household":"۱ عدد متوسط رو به بزرگ"},{"name":"سیب‌زمینی کبابی","amount":"۱۶۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب‌زمینی آب‌پز یا کبابی — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 5,
    'snack:15:سیبزمینی-آبپز-یا-کبابی:200', '[{"name":"سیب‌زمینی آب‌پز","amount":"۲۳۰ گرم","household":"۱ عدد بزرگ"},{"name":"سیب‌زمینی کبابی","amount":"۲۱۵ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب‌زمینی آب‌پز یا کبابی — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 7,
    'snack:15:سیبزمینی-آبپز-یا-کبابی:250', '[{"name":"سیب‌زمینی آب‌پز","amount":"۲۸۵ گرم","household":"۲ عدد متوسط"},{"name":"سیب‌زمینی کبابی","amount":"۲۷۰ گرم","household":"۲ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست و موز و جو دوسر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست و موز و جو دوسر', 'compound', 'snack', 'filling', 'snack:16:ماست-و-موز-و-جو-دوسر', 'ماست سادهٔ کم‌چرب، موز بدون پوست و جو دوسر خشک؛ بدون عسل، شکر و مغزها. وزن جو دوسر پیش از خیساندن و وزن موز بدون پوست است. تمام مواد نوشته‌شده در کالری و پروتئین همان نسخه حساب شده‌اند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و موز و جو دوسر — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 6,
    'snack:16:ماست-و-موز-و-جو-دوسر:150', '[{"name":"ماست کم‌چرب","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۵۵ گرم","household":"حدود نصف یک موز کوچک"},{"name":"جو دوسر خشک","amount":"۱۰ گرم","household":"۲ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و موز و جو دوسر — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 10,
    'snack:16:ماست-و-موز-و-جو-دوسر:200', '[{"name":"ماست کم‌چرب","amount":"۱۵۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۶۰ گرم","household":"نصف یک موز متوسط"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و موز و جو دوسر — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 12,
    'snack:16:ماست-و-موز-و-جو-دوسر:250', '[{"name":"ماست کم‌چرب","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"موز","amount":"۸۰ گرم","household":"حدود ⅔ یک موز متوسط"},{"name":"جو دوسر خشک","amount":"۱۵ گرم","household":"۳ قاشق غذاخوری سرصاف"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;

-- Summary: 100 base foods, 336 versions
-- Total records: 436

END $$;
