class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230315"
    checksums = {
        "darwin_arm64" => "370c471dc012df86a519bc441b1b641a91444815c266425ff54317d8e8ae971f",
        "darwin_amd64" => "9f5cd8420cb7f7b146070f85431cd82246ace58476d4b33d012696f2f6daa461",
        "linux_arm64"  => "2da6f1cc23bec488aaa4af7afea662199c097ba5932f81cc67e8fa117f80ebe4",
        "linux_amd64"  => "37b54cf5727131f6faf0d517db490d20971a313fa5027bb7e3841b1b50aa0511",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
