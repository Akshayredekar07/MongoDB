#!/bin/bash



echo "Renaming markdown files for consistency..."

# Create an associative array for file renaming
declare -A rename_map

# Define mappings for consistent naming with underscores between words
rename_map["S01.IntoductionMongoDB.md"]="S01_Introduction_To_MongoDB.md"
rename_map["S01.mongodb_30.md"]="S01_MongoDB_Overview_Guide.md"
rename_map["S02.InstallationMongoDB.md"]="S02_Installation_Process.md"
rename_map["S02.mongodb29.md"]="S02_Setup_Configuration.md"
rename_map["S03.IntroductionCRUD.md"]="S03_CRUD_Operations_Basics.md"
rename_map["S03.readme.md"]="S03_Documentation_Guide.md"
rename_map["S04.NestetedDocs&ObjectId.md"]="S04_Nested_Documents_And_IDs.md"
rename_map["S04.test.md"]="S04_Testing_Procedures.md"
rename_map["S05.WriteConcerns&Automicity.md"]="S05_Write_Concerns_Guide.md"
rename_map["S06.InsertOperation.md"]="S06_Insert_Operations.md"
rename_map["S07.QueryNestedDocument.md"]="S07_Querying_Nested_Docs.md"
rename_map["S08.ComparisionOperators.md"]="S08_Comparison_Operators.md"
rename_map["S09.LogicalQueryOperators01.md"]="S09_Logical_Operators_Part1.md"
rename_map["S10.LogicalQueryOperators02.md"]="S10_Logical_Operators_Part2.md"
rename_map["S11.Element Query Operator.md"]="S11_Element_Query_Operators.md"
rename_map["S12.query operator and regex.md"]="S12_Regex_Query_Operators.md"
rename_map["S13.Query Operators usecase.md"]="S13_Query_Operators_Usage.md"
rename_map["S14.Import data and cursor.md"]="S14_Import_Data_And_Cursors.md"
rename_map["S15.cursor helper methods.md"]="S15_Cursor_Helper_Methods.md"
rename_map["S16.Projection.md"]="S16_Projection_Techniques.md"
rename_map["S17.Project on array.md"]="S17_Array_Projection.md"
rename_map["S18.Update Operation.md"]="S18_Update_Operations.md"
rename_map["S19.Update Operators.md"]="S19_Update_Operators_List.md"
rename_map["S22.Update operators part2.md"]="S22_Advanced_Update_Ops.md"
rename_map["S23.push pop and other.md"]="S23_Array_Update_Methods.md"
rename_map["S24.Modifers sclice and sort.md"]="S24_Array_Modifiers.md"
rename_map["S25.Assginment on agg.md"]="S25_Aggregation_Tasks.md"
rename_map["S25.set and other.md"]="S25_Set_Operator_Guide.md"
rename_map["S26.Delete Operataion.md"]="S26_Delete_Operations.md"
rename_map["S27.MongoDB utility.md"]="S27_MongoDB_Utilities.md"
rename_map["S28.Utility part2.md"]="S28_Advanced_Utilities.md"
rename_map["S29.GUI tools for mongodb.md"]="S29_GUI_Tools_For_MongoDB.md"
rename_map["S31.MongoDB indexing.md"]="S31_Indexing_Strategies.md"
rename_map["S32.Aggregation part1.md"]="S32_Aggregation_Basics.md"
rename_map["S33.Aggregation pipeline.md"]="S33_Aggregation_Pipeline.md"
rename_map["S34.Agg part3.md"]="S34_Advanced_Aggregation.md"
rename_map["S36.Map reduce in mongodb.md"]="S36_Map_Reduce_Patterns.md"
rename_map["S37.Mongodb with py.md"]="S37_Python_Integration.md"

# Perform the renaming
for old_name in "${!rename_map[@]}"; do
    new_name="${rename_map[$old_name]}"
    
    if [ -f "$old_name" ]; then
        mv "$old_name" "$new_name"
        echo "Renamed: $old_name -> $new_name"
    else
        echo "Warning: File $old_name not found"
    fi
done

# List all files that may not have been included in the rename map
echo -e "\nChecking for any remaining inconsistent files..."
ls | grep -v "^S[0-9][0-9]_"

echo -e "\nRenamed files:"
ls -1 S*_*.md | sort

cd ..
echo -e "\nRenaming complete!"
