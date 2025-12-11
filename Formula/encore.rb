class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.52.5"
    checksums = {
        "darwin_arm64" => "5f5d5fbe9b57df973f7ae9a87be69bdff21e0da717613adb6eec5efdb750a4db",
        "darwin_amd64" => "9002d7c0d449570b04e841fcf871f9c11157bf540c43e11ee6d8dc699cbec2da",
        "linux_arm64"  => "54de6b849765e7edd139031b0d7e0f1f4ba6577387a20f00c2a4df498b75d6dc",
        "linux_amd64"  => "7817d24145270a454668d51e0b81a9257ba877183ada2e3647d19e9b3b207f01",
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
