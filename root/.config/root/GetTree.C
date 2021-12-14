
TTree* GetTree(TFile *file, TString treeName) {
    TTree *tree = nullptr;
    file->GetObject(treeName, tree);
    return tree;
}
