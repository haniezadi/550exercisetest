DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: دو عدد تخم‌مرغ و نان سنگک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('دو عدد تخم‌مرغ و نان سنگک', 'compound', 'snack', 'filling', 'snack:12:دو-عدد-تخممرغ-و-نان-سنگک', 'دو تخم‌مرغ آب‌پز بدون روغن. چون خود دو تخم‌مرغ حدود ۱۴۰ کالری دارند، پایین‌ترین نسخهٔ کاربردی این گزینه حدود ۱۸۰ کالری است. تعداد تخم‌مرغ در هر سه نسخه دقیقاً دو عدد است. وزن بدون پوسته و بدون روغن محاسبه شده است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 180 cal, 14g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دو عدد تخم‌مرغ و نان سنگک — 180 کالری', 'compound', 'snack', 'filling',
    v_base_id, '180 کالری', 180, 14,
    'snack:12:دو-عدد-تخممرغ-و-نان-سنگک:180', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"},{"name":"نان سنگک","amount":"۱۵ گرم","household":"½ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 14g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دو عدد تخم‌مرغ و نان سنگک — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 14,
    'snack:12:دو-عدد-تخممرغ-و-نان-سنگک:200', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"},{"name":"نان سنگک","amount":"۲۲ گرم","household":"حدود ¾ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 16g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دو عدد تخم‌مرغ و نان سنگک — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 16,
    'snack:12:دو-عدد-تخممرغ-و-نان-سنگک:250', '[{"name":"تخم‌مرغ آب‌پز","amount":"۱۰۰ گرم","household":"۲ عدد"},{"name":"نان سنگک","amount":"۴۱ گرم","household":"حدود ۱⅓ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پنیر و گردو و نان سنگک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پنیر و گردو و نان سنگک', 'compound', 'snack', 'filling', 'snack:13:پنیر-و-گردو-و-نان-سنگک', 'پنیر سفید معمولی، مغز گردو و نان سنگک؛ بدون کره. وزن گردو مربوط به مغز بدون پوست سخت است. پنیر خامه‌ای یا پنیر پرچرب‌تر باید با اطلاعات محصول محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و گردو و نان سنگک — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 5,
    'snack:13:پنیر-و-گردو-و-نان-سنگک:150', '[{"name":"پنیر سفید","amount":"۲۰ گرم","household":"حدود ⅔ قوطی کبریت"},{"name":"مغز گردو","amount":"۴ گرم","household":"۱ مغز کامل متوسط"},{"name":"نان سنگک","amount":"۲۸ گرم","household":"حدود ۱ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و گردو و نان سنگک — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 6,
    'snack:13:پنیر-و-گردو-و-نان-سنگک:200', '[{"name":"پنیر سفید","amount":"۲۵ گرم","household":"کمی کمتر از ۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۸ گرم","household":"۲ مغز کامل متوسط"},{"name":"نان سنگک","amount":"۳۲ گرم","household":"کمی بیشتر از ۱ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و گردو و نان سنگک — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 8,
    'snack:13:پنیر-و-گردو-و-نان-سنگک:250', '[{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"مغز گردو","amount":"۸ گرم","household":"۲ مغز کامل متوسط"},{"name":"نان سنگک","amount":"۴۶ گرم","household":"حدود ۱½ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سیب‌زمینی آب‌پز و تخم‌مرغ (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سیب‌زمینی آب‌پز و تخم‌مرغ', 'compound', 'snack', 'filling', 'snack:14:سیبزمینی-آبپز-و-تخممرغ', 'سیب‌زمینی آب‌پز و تخم‌مرغ آب‌پز، بدون روغن، کره و مایونز. وزن سیب‌زمینی مربوط به حالت پخته و قسمت خوراکی است. سس، روغن و کره در محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب‌زمینی آب‌پز و تخم‌مرغ — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 8,
    'snack:14:سیبزمینی-آبپز-و-تخممرغ:150', '[{"name":"سیب‌زمینی آب‌پز","amount":"۹۰ گرم","household":"۱ عدد کوچک"},{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب‌زمینی آب‌پز و تخم‌مرغ — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 9,
    'snack:14:سیبزمینی-آبپز-و-تخممرغ:200', '[{"name":"سیب‌زمینی آب‌پز","amount":"۱۴۵ گرم","household":"۱ عدد متوسط"},{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب‌زمینی آب‌پز و تخم‌مرغ — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 10,
    'snack:14:سیبزمینی-آبپز-و-تخممرغ:250', '[{"name":"سیب‌زمینی آب‌پز","amount":"۲۰۵ گرم","household":"۱ عدد بزرگ یا ۲ عدد کوچک"},{"name":"تخم‌مرغ آب‌پز","amount":"۵۰ گرم","household":"۱ عدد"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
