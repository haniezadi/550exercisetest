DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  -- Base food: شیر و موز (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیر و موز', 'compound', 'snack', 'filling', 'snack:3:شیر-و-موز', 'شیر کم‌چرب و موز بدون پوست؛ یک موز متوسط حدود ۱۲۰ گرم قسمت خوراکی دارد. عسل، خرما، بستنی یا پودر شیرین در محاسبه نیستند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 8g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و موز — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 8,
    'snack:3:شیر-و-موز:150', '[{"name":"شیر کم‌چرب","amount":"۲۰۰ میلی‌لیتر","household":"حدود ⅞ لیوان استاندارد"},{"name":"موز","amount":"۶۵ گرم","household":"حدود نصف یک موز متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و موز — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 9,
    'snack:3:شیر-و-موز:200', '[{"name":"شیر کم‌چرب","amount":"۲۳۰ میلی‌لیتر","household":"۱ لیوان استاندارد"},{"name":"موز","amount":"۱۰۵ گرم","household":"۱ موز کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیر و موز — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 12,
    'snack:3:شیر-و-موز:250', '[{"name":"شیر کم‌چرب","amount":"۳۰۰ میلی‌لیتر","household":"حدود ۱⅓ لیوان استاندارد"},{"name":"موز","amount":"۱۲۵ گرم","household":"۱ موز متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: سیب و بادام (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('سیب و بادام', 'compound', 'snack', 'filling', 'snack:4:سیب-و-بادام', 'سیب با پوست خوراکی و بادام بدون روغن یا روکش. وزن سیب بدون هسته و دم است. بادام شکری یا شکلاتی جایگزین مستقیم این سهم نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب و بادام — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 4,
    'snack:4:سیب-و-بادام:150', '[{"name":"سیب","amount":"۱۱۵ گرم","household":"یک واحد میوه؛ ۱ سیب کوچک"},{"name":"بادام","amount":"۱۶ گرم","household":"۱۳ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 5g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب و بادام — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 5,
    'snack:4:سیب-و-بادام:200', '[{"name":"سیب","amount":"۱۵۰ گرم","household":"حدود ۱⅓ واحد میوه؛ ۱ سیب متوسط"},{"name":"بادام","amount":"۲۱ گرم","household":"۱۸ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 6g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'سیب و بادام — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 6,
    'snack:4:سیب-و-بادام:250', '[{"name":"سیب","amount":"۱۸۰ گرم","household":"حدود ۱½ واحد میوه؛ ۱ سیب متوسط رو به بزرگ"},{"name":"بادام","amount":"۲۷ گرم","household":"۲۳ مغز کامل بادام"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: خرما و گردو (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('خرما و گردو', 'compound', 'snack', 'filling', 'snack:5:خرما-و-گردو', 'خرمای کوچک تا متوسطِ بدون هسته و مغز گردو؛ هر خرمای مبنا حدود ۸ گرم. خرمای درشت با همین تعداد، کالری بیشتری دارد؛ وزن قسمت خوراکی ملاک است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما و گردو — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 2,
    'snack:5:خرما-و-گردو:150', '[{"name":"خرمای بدون هسته","amount":"۲۴ گرم","household":"۳ عدد کوچک تا متوسط"},{"name":"مغز گردو","amount":"۱۲ گرم","household":"۳ مغز کامل متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما و گردو — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 3,
    'snack:5:خرما-و-گردو:200', '[{"name":"خرمای بدون هسته","amount":"۳۲ گرم","household":"۴ عدد کوچک تا متوسط"},{"name":"مغز گردو","amount":"۱۶ گرم","household":"۴ مغز کامل متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'خرما و گردو — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 4,
    'snack:5:خرما-و-گردو:250', '[{"name":"خرمای بدون هسته","amount":"۴۰ گرم","household":"۵ عدد کوچک تا متوسط"},{"name":"مغز گردو","amount":"۲۱ گرم","household":"حدود ۵ مغز کامل متوسط رو به بزرگ"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
