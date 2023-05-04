class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230504"
    checksums = {
        "darwin_arm64" => "1fa7bdd25d3186be9231df46024e0d533dd788366320d43d0613dc605d534fda",
        "darwin_amd64" => "c2b0b93f44c79decd751e60f6dd4fd9982a2e5a385638f001a7cc8f14d15f98b",
        "linux_arm64"  => "2fb45e29cac62d1a423cdbdd8f23342ff26326f48fc3ffaaa485514ee4b419ff",
        "linux_amd64"  => "368ad6fd9bcffe4fbb1fdde037fa36befb7162d2227447cbbef16f81ec3e4234",
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
