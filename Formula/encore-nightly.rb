class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230610"
    checksums = {
        "darwin_arm64" => "23f885fb353419a8f0abc74886bc93a8fea67d348b9c7744be99c13b7b1ab528",
        "darwin_amd64" => "e1b7b0aefad94705230cfe5a1d1853377885ab3cd8ae781408891861cfc7bfd5",
        "linux_arm64"  => "dbec4f466a5dda53e559ea79c386d15cf8a52f5db80876982501f1e2b2b36248",
        "linux_amd64"  => "cd11af5e71712f594ea408cde4dd2de8c32b73eb708edda2eba388e7a17a6b45",
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
