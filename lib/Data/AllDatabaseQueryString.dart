String getAllFarmersQuery =
    "SELECT * from farmers a LEFT JOIN farmer_categories b ON a.farmer_category_id=b.id LEFT JOIN districts c ON a.district_id=c.id";
