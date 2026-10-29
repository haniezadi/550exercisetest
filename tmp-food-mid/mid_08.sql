DO $$ 
DECLARE
  v_base_id uuid;
BEGIN

  
  -- Base food: کراکر (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('کراکر', 'compound', 'snack', 'simple', 'snack:11:کراکر', 'کراکر ساده با حدود ۴۵۰ کالری / ۸ گرم پروتئین در ۱۰۰ گرم؛ هر عدد فرضی حدود ۵ گرم. پنیر، کره یا هر خوراکی همراه کراکر در این سهم نیست.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کراکر — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:11:کراکر:100', '[{"name":"کراکر","amount":"۲۲ گرم","household":"حدود ۴–۵ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کراکر — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 3,
    'snack:11:کراکر:150', '[{"name":"کراکر","amount":"۳۳ گرم","household":"حدود ۶–۷ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 4g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'کراکر — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 4,
    'snack:11:کراکر:200', '[{"name":"کراکر","amount":"۴۴ گرم","household":"حدود ۹ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: شیرینی خشک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('شیرینی خشک', 'compound', 'snack', 'simple', 'snack:12:شیرینی-خشک', 'شیرینی خشک ساده با حدود ۴۸۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم؛ هر عدد کوچک فرضی حدود ۱۰ گرم. شیرینی خشک انواع متفاوتی دارد؛ نسخه‌های کره‌ای، مغزدار و شکلاتی الزاماً همین کالری را ندارند.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 1g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیرینی خشک — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 1,
    'snack:12:شیرینی-خشک:100', '[{"name":"شیرینی خشک","amount":"۲۱ گرم","household":"حدود ۲ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیرینی خشک — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:12:شیرینی-خشک:150', '[{"name":"شیرینی خشک","amount":"۳۱ گرم","household":"حدود ۳ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'شیرینی خشک — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:12:شیرینی-خشک:200', '[{"name":"شیرینی خشک","amount":"۴۲ گرم","household":"حدود ۴ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: دونات کوچک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('دونات کوچک', 'compound', 'snack', 'simple', 'snack:13:دونات-کوچک', 'دونات ساده بدون کرم و روکش سنگین با حدود ۴۰۰ کالری / ۶ گرم پروتئین در ۱۰۰ گرم؛ دونات کوچک فرضی ۵۰ گرمی. دونات کرم‌دار، شکلاتی یا با لعاب زیاد باید جدا محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دونات کوچک — 100 کالری', 'compound', 'snack', 'simple',
    v_base_id, '100 کالری', 100, 2,
    'snack:13:دونات-کوچک:100', '[{"name":"دونات","amount":"۲۵ گرم","household":"نصف یک دونات کوچک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 2g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دونات کوچک — 150 کالری', 'compound', 'snack', 'simple',
    v_base_id, '150 کالری', 150, 2,
    'snack:13:دونات-کوچک:150', '[{"name":"دونات","amount":"۳۸ گرم","household":"حدود ¾ یک دونات کوچک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 3g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'دونات کوچک — 200 کالری', 'compound', 'snack', 'simple',
    v_base_id, '200 کالری', 200, 3,
    'snack:13:دونات-کوچک:200', '[{"name":"دونات","amount":"۵۰ گرم","household":"۱ عدد دونات کوچک ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: پروتئین‌بار (breakfast)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پروتئین‌بار', 'compound', 'breakfast', NULL, 'breakfast:15:پروتئینبار', 'یک پروتئین‌بار فرضی ۵۰ گرمی با ۲۰۰ کالری و ۲۰ گرم پروتئین.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 100 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 100 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '100 کالری', 100, 10,
    'breakfast:15:پروتئینبار:100', '[{"name":"پروتئین‌بار","amount":"۲۵ گرم","household":"نصف یک بار ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 150 cal, 15g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 150 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '150 کالری', 150, 15,
    'breakfast:15:پروتئینبار:150', '[{"name":"پروتئین‌بار","amount":"۳۸ گرم","household":"حدود ¾ یک بار ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 200 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '200 کالری', 200, 20,
    'breakfast:15:پروتئینبار:200', '[{"name":"پروتئین‌بار","amount":"۵۰ گرم","household":"۱ عدد بار ۵۰ گرمی"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 20g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پروتئین‌بار — 200 کالری', 'compound', 'breakfast', NULL,
    v_base_id, '200 کالری', 200, 20,
    'breakfast:15:پروتئینبار:200', 'null', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست و گردو (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست و گردو', 'compound', 'snack', 'filling', 'snack:1:ماست-و-گردو', 'ماست سادهٔ کم‌چرب و مغز گردوی بدون پوست سخت؛ هر مغز کامل گردوی متوسط حدود ۴ گرم. عسل، کشمش و شکر در محاسبه نیستند. وزن گردو ملاک دقیق‌تر از تعداد است.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و گردو — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 7,
    'snack:1:ماست-و-گردو:150', '[{"name":"ماست کم‌چرب","amount":"۱۵۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"مغز گردو","amount":"۹ گرم","household":"حدود ۲ مغز کامل بزرگ"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و گردو — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 10,
    'snack:1:ماست-و-گردو:200', '[{"name":"ماست کم‌چرب","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"مغز گردو","amount":"۱۲ گرم","household":"۳ مغز کامل متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 12g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و گردو — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 12,
    'snack:1:ماست-و-گردو:250', '[{"name":"ماست کم‌چرب","amount":"۲۵۰ گرم","household":"۱ کاسهٔ کوچک پُر"},{"name":"مغز گردو","amount":"۱۵ گرم","household":"حدود ۴ مغز کامل کوچک تا متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Base food: ماست و نان سنگک (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('ماست و نان سنگک', 'compound', 'snack', 'filling', 'snack:2:ماست-و-نان-سنگک', 'ماست سادهٔ کم‌چرب و نان سنگک؛ هر ۳۰ گرم نان حدود ۱ کف دست بدون انگشتان. ماست چکیده یا پرچرب، با همین وزن کالری و پروتئین متفاوتی دارد.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و نان سنگک — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 7,
    'snack:2:ماست-و-نان-سنگک:150', '[{"name":"ماست کم‌چرب","amount":"۱۰۰ گرم","household":"۶–۷ قاشق غذاخوری سرصاف"},{"name":"نان سنگک","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و نان سنگک — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 10,
    'snack:2:ماست-و-نان-سنگک:200', '[{"name":"ماست کم‌چرب","amount":"۱۵۰ گرم","household":"۱۰ قاشق غذاخوری سرصاف"},{"name":"نان سنگک","amount":"۴۲ گرم","household":"حدود ۱½ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 13g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'ماست و نان سنگک — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 13,
    'snack:2:ماست-و-نان-سنگک:250', '[{"name":"ماست کم‌چرب","amount":"۲۰۰ گرم","household":"۱۳ قاشق غذاخوری سرصاف"},{"name":"نان سنگک","amount":"۵۰ گرم","household":"۱⅔ کف دست"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

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

  -- Base food: پنیر و نان سنگک و خیار (snack)
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, source_key, notes)
  VALUES ('پنیر و نان سنگک و خیار', 'compound', 'snack', 'filling', 'snack:6:پنیر-و-نان-سنگک-و-خیار', 'پنیر سفید معمولی با حدود ۲۶۰ کالری / ۱۴ گرم پروتئین در ۱۰۰ گرم؛ بدون کره و گردوی اضافه. پنیر خامه‌ای یا پنیر با درصد چربی متفاوت، باید بر اساس برچسب خودش محاسبه شود.')
  ON CONFLICT (source_key) DO UPDATE SET name = EXCLUDED.name, meal_type = EXCLUDED.meal_type, snack_subtype = EXCLUDED.snack_subtype
  RETURNING id INTO v_base_id;

  -- Version: 150 cal, 7g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و نان سنگک و خیار — 150 کالری', 'compound', 'snack', 'filling',
    v_base_id, '150 کالری', 150, 7,
    'snack:6:پنیر-و-نان-سنگک-و-خیار:150', '[{"name":"پنیر سفید","amount":"۳۰ گرم","household":"۱ قوطی کبریت"},{"name":"نان سنگک","amount":"۲۵ گرم","household":"کمی کمتر از ۱ کف دست"},{"name":"خیار","amount":"۵۰ گرم","household":"۱ عدد کوچک"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 200 cal, 9g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و نان سنگک و خیار — 200 کالری', 'compound', 'snack', 'filling',
    v_base_id, '200 کالری', 200, 9,
    'snack:6:پنیر-و-نان-سنگک-و-خیار:200', '[{"name":"پنیر سفید","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ قوطی کبریت"},{"name":"نان سنگک","amount":"۳۵ گرم","household":"کمی بیشتر از ۱ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

  -- Version: 250 cal, 10g protein
  INSERT INTO foods (name, food_type, meal_type, snack_subtype, parent_food_id, version_label, calories, protein, source_key, ingredients, notes)
  VALUES (
    'پنیر و نان سنگک و خیار — 250 کالری', 'compound', 'snack', 'filling',
    v_base_id, '250 کالری', 250, 10,
    'snack:6:پنیر-و-نان-سنگک-و-خیار:250', '[{"name":"پنیر سفید","amount":"۴۰ گرم","household":"۱⅓ قوطی کبریت"},{"name":"نان سنگک","amount":"۵۰ گرم","household":"۱⅔ کف دست"},{"name":"خیار","amount":"۱۰۰ گرم","household":"۱ عدد متوسط"}]', NULL
  )
  ON CONFLICT (source_key) DO UPDATE SET
    parent_food_id = v_base_id, calories = EXCLUDED.calories, protein = EXCLUDED.protein,
    ingredients = EXCLUDED.ingredients, version_label = EXCLUDED.version_label;

END $$;
