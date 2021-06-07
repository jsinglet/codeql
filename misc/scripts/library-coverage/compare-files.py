import sys
import os
import settings
import difflib
import utils

"""
This script compares the generated CSV coverage files with the ones in the codebase.
"""


def check_file_exists(file):
    if not os.path.exists(file):
        print("Expected file '" + file + "' doesn't exist.", file=sys.stderr)
        return False
    return True


def ignore_line_ending(ch):
    return difflib.IS_CHARACTER_JUNK(ch, ws=" \r\n")


def compare_files(file1, file2):
    messages = compare_files_str(file1, file2)
    if messages == "":
        return True

    print(messages, end="", file=sys.stderr)

    return False


def compare_files_str(file1, file2):
    diff = difflib.ndiff(open(file1).readlines(),
                         open(file2).readlines(), None, ignore_line_ending)
    ret = ""
    for line in diff:
        if line.startswith("+") or line.startswith("-"):
            ret += line

    return ret


def comment_pr(folder1, folder2, output_file, pr_number, run_id):
    compare_folders(folder1, folder2, output_file)
    size = os.path.getsize(output_file)
    if size == 0:
        print("No difference in the coverage reports")
        return

    comment = ":warning: The head of this PR and the base branch were compared for differences in the CSV coverage reports. " + \
        "The generated reports are available in the [artifacts of this workflow run](https://github.com/github/codeql/actions/runs/" + run_id + "). "

    if size < 2000:
        print("There's a small change in the CSV coverage reports")
        comment += "The following differences were found: \n\n"
        with open(output_file, 'r') as file:
            comment += file.read()
    else:
        print("There's a large change in the CSV coverage reports")
        comment += "The differences can be found in the " + \
            output_file + " artifact of this job."

    post_comment(comment, pr_number)


def post_comment(comment, pr_number):
    print("Posting comment to PR #" + str(pr_number))
    utils.subprocess_run(["gh", "pr", "comment", pr_number,
                         "--repo", "github/codeql", "--body", comment])


def compare_folders(folder1, folder2, output_file):
    languages = ['java']

    return_md = ""

    for lang in languages:
        expected_files = ""

        generated_output_rst = settings.generated_output_rst.format(
            language=lang)
        generated_output_csv = settings.generated_output_csv.format(
            language=lang)

        # check if files exist in both folder1 and folder 2
        if not check_file_exists(folder1 + "/" + generated_output_rst):
            expected_files += "- " + generated_output_rst + \
                " doesn't exist in folder " + folder1 + "\n"
        if not check_file_exists(folder2 + "/" + generated_output_rst):
            expected_files += "- " + generated_output_rst + \
                " doesn't exist in folder " + folder2 + "\n"
        if not check_file_exists(folder1 + "/" + generated_output_csv):
            expected_files += "- " + generated_output_csv + \
                " doesn't exist in folder " + folder1 + "\n"
        if not check_file_exists(folder2 + "/" + generated_output_csv):
            expected_files += "- " + generated_output_csv + \
                " doesn't exist in folder " + folder2 + "\n"

        if expected_files != "":
            print("Expected files are missing", file=sys.stderr)
            return_md += "\n### " + lang + "\n\n#### Expected files are missing for " + \
                lang + "\n" + expected_files + "\n"
            continue

        # compare contents of files
        cmp1 = compare_files_str(
            folder1 + "/" + generated_output_rst, folder2 + "/" + generated_output_rst)
        cmp2 = compare_files_str(
            folder1 + "/" + generated_output_csv, folder2 + "/" + generated_output_csv)

        if cmp1 != "" or cmp2 != "":
            print("Generated file contents are not matching", file=sys.stderr)
            return_md += "\n### " + lang + "\n\n#### Generated files are not matching for " + \
                lang + "\n\n"
            if cmp1 != "":
                return_md += "- Mismatch in " + generated_output_rst + ":\n```\n" + cmp1 + "```\n\n"
            if cmp2 != "":
                return_md += "- Mismatch in " + generated_output_csv + ":\n```\n" + cmp2 + "```\n\n"

    with open(output_file, 'w', newline='') as out:
        out.write(return_md)


comment_pr(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])


# def compare_generated_and_repo_files():
#     languages = ['java']

#     all_ok = True

#     for lang in languages:
#         repo_output_rst = settings.repo_output_rst.format(language=lang)
#         repo_output_csv = settings.repo_output_csv.format(language=lang)

#         generated_output_rst = settings.generated_output_rst.format(
#             language=lang)
#         generated_output_csv = settings.generated_output_csv.format(
#             language=lang)

#         exists = check_file_exists(repo_output_rst)
#         if not exists:
#             sys.exit(1)

#         exists = check_file_exists(repo_output_csv)
#         if not exists:
#             sys.exit(1)

#         exists = check_file_exists(generated_output_rst)
#         if not exists:
#             sys.exit(1)

#         exists = check_file_exists(generated_output_csv)
#         if not exists:
#             sys.exit(1)

#         docs_folder = settings.documentation_folder_no_prefix.format(
#             language=lang)

#         rst_ok = compare_files(repo_output_rst, generated_output_rst)
#         if not rst_ok:
#             print("The generated file doesn't match the one in the codebase. Please check and fix file '" +
#                   docs_folder + settings.output_rst_file_name + "'.", file=sys.stderr)
#         csv_ok = compare_files(repo_output_csv, generated_output_csv)
#         if not csv_ok:
#             print("The generated file doesn't match the one in the codebase. Please check and fix file '" +
#                   docs_folder + settings.output_csv_file_name + "'.", file=sys.stderr)

#         if not rst_ok or not csv_ok:
#             print("The generated CSV coverage report files for '" + lang + "' don't match the ones in the codebase. Please update the files in '" +
#                   docs_folder + "'. The new files can be downloaded from the artifacts of this job.", file=sys.stderr)
#             all_ok = False
#         else:
#             print("The generated files for '" + lang +
#                   "' match the ones in the codebase.")

#     if not all_ok:
#         sys.exit(1)
