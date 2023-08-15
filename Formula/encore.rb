class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.25.0"
    checksums = {
        "darwin_arm64" => "34407e612cfc2f1c6a4ec369ce07c1089a122dd4532ebc501b445055e0df0512",
        "darwin_amd64" => "2214736c754c44ae2f18b4b114c688c3eed0c2ed2cf249091e36491c4bbeed11",
        "linux_arm64"  => "839f0a359a2b8ce6559882b21c2905df4b169048bd6bc7b590573a34a6c50493",
        "linux_amd64"  => "a52891333a726c876c76cd9b78a7e73585a18c657701a788a1a4e029616b7be2",
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
