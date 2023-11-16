class EncoreBeta < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.29.0-beta.1"
    checksums = {
        "darwin_arm64" => "a0a24f0cb9c2eb1842aaa2dd5f480231d7e1cf6a6219c5e732df09a1fe13a1b6",
        "darwin_amd64" => "e3d2d087721b6e3f502b194ca32c07a43d517127b20c85a9a12dc3a33a29425d",
        "linux_arm64"  => "44f0ecee970c1de4b73692d179742d4736c196bef52f2b63b99071f05d3082ad",
        "linux_amd64"  => "d6c9c778fa52692f508da6a142bb90654068ed5066260013e5eea4f01fc87077",
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

        bin.install_symlink libexec/"bin/encore-beta"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "bash")
        (bash_completion/"encore-beta").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "zsh")
        (zsh_completion/"_encore-beta").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-beta", "completion", "fish")
        (fish_completion/"encore-beta.fish").write output
    end

    test do
        system "#{bin}/encore-beta", "check"
    end
end
